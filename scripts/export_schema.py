#!/usr/bin/env python3
"""
Export PostgreSQL schema objects into one SQL file per pg_dump object section.

Requirements:
  - Python 3.10+
  - PostgreSQL client tools (psql and pg_dump) installed and on PATH
  - A database role with sufficient visibility/read privileges

Credentials:
  - Uses PGHOST, PGPORT, PGDATABASE, PGUSER environment variables.
  - If PGPASSWORD is not set, prompts securely without echoing.
  - Never writes the password into files or command-line arguments.

This is a source-control baseline exporter, not a production deployment tool.
Always review the output and test restore/deployment ordering separately.
"""
from __future__ import annotations

import argparse
import getpass
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Optional

SCHEMA_QUERY = r"""
SELECT nspname
FROM pg_catalog.pg_namespace
WHERE nspname <> 'information_schema'
  AND nspname NOT LIKE 'pg_%'
ORDER BY nspname;
"""

# pg_dump emits these markers before object sections. Keep each section in a
# separate file; repeated sections for the same marker are numbered.
MARKER_RE = re.compile(
    r"^-- Name: (?P<name>.*?); Type: (?P<type>.*?); Schema: (?P<schema>.*?);",
    re.MULTILINE,
)

TYPE_DIR = {
    "TABLE": "tables",
    "FOREIGN TABLE": "foreign_tables",
    "VIEW": "views",
    "MATERIALIZED VIEW": "materialized_views",
    "SEQUENCE": "sequences",
    "SEQUENCE OWNED BY": "sequences",
    "TABLE ATTACH": "partitioning",
    "FUNCTION": "functions",
    "PROCEDURE": "procedures",
    "AGGREGATE": "aggregates",
    "TYPE": "types",
    "DOMAIN": "domains",
    "ENUM": "types",
    "COLLATION": "collations",
    "CONVERSION": "conversions",
    "OPERATOR": "operators",
    "OPERATOR CLASS": "operator_classes",
    "OPERATOR FAMILY": "operator_families",
    "TEXT SEARCH CONFIGURATION": "text_search",
    "TEXT SEARCH DICTIONARY": "text_search",
    "TEXT SEARCH PARSER": "text_search",
    "TEXT SEARCH TEMPLATE": "text_search",
    "STATISTICS": "statistics",
    "PUBLICATION": "publications",
    "SUBSCRIPTION": "subscriptions",
    "POLICY": "policies",
    "ROW SECURITY": "policies",
    "TRIGGER": "triggers",
    "RULE": "rules",
    "INDEX": "indexes",
    "INDEX ATTACH": "indexes",
    "CONSTRAINT": "constraints",
    "FK CONSTRAINT": "constraints",
    "DEFAULT": "defaults",
    "ACL": "privileges",
    "COMMENT": "comments",
    "EXTENSION": "extensions",
    "SCHEMA": ".",
}

def run(cmd: list[str], *, env: dict[str, str], capture: bool = True) -> str:
    try:
        result = subprocess.run(
            cmd, env=env, text=True,
            stdout=subprocess.PIPE if capture else None,
            stderr=subprocess.PIPE, check=False
        )
    except FileNotFoundError as exc:
        raise RuntimeError(
            f"Could not find '{cmd[0]}'. Install PostgreSQL client tools and add them to PATH."
        ) from exc
    if result.returncode != 0:
        err = (result.stderr or "").strip()
        # Avoid printing environment or credentials.
        raise RuntimeError(f"Command failed ({result.returncode}): {cmd[0]} ...\n{err}")
    return result.stdout or ""

def safe_name(value: str, limit: int = 100) -> str:
    original = value.strip().strip('"')
    value = re.sub(r'[<>:"/\\|?*\x00-\x1f]', "_", original)
    value = re.sub(r"\s+", "_", value)
    value = re.sub(r"_+", "_", value).strip(" ._") or "unnamed"

    if len(value) > limit:
        digest = hashlib.sha256(original.encode("utf-8")).hexdigest()[:10]
        value = value[:limit - 11] + "_" + digest

    return value

def read_password() -> str:
    existing = os.environ.get("PGPASSWORD")
    if existing:
        return existing
    return getpass.getpass("PostgreSQL password (input hidden; not saved): ")

def parse_marker(line: str) -> Optional[dict[str, str]]:
    match = MARKER_RE.match(line)
    if not match:
        return None
    return {k: v.strip() for k, v in match.groupdict().items()}

def split_dump(dump_text: str) -> tuple[list[dict], list[str]]:
    """Split pg_dump output into object sections based on pg_dump's own markers."""
    lines = dump_text.splitlines(keepends=True)
    sections: list[dict] = []
    preamble: list[str] = []
    current = None

    for line in lines:
        marker = parse_marker(line)
        if marker:
            if current:
                sections.append(current)
            current = {"meta": marker, "lines": [line]}
        elif current is not None:
            # pg_dump's end marker belongs to the final section; it is harmless
            # to keep it there, but it is clearer in a schema-level file.
            if line.startswith("-- PostgreSQL database dump complete"):
                sections.append(current)
                current = None
                preamble.append(line)
            else:
                current["lines"].append(line)
        else:
            preamble.append(line)

    if current:
        sections.append(current)
    return sections, preamble

def write_object_files(schema_dir: Path, dump_text: str) -> dict:
    sections, preamble = split_dump(dump_text)
    counts: dict[str, int] = {}
    inventory = []

    # Keep dump header and any unclassified SQL in schema.sql as a reference
    # and to avoid silently dropping commands not represented by a Name marker.
    schema_file_parts = [
        "-- Generated by scripts/export_schema.py. Review before deployment.\n",
        "-- This file preserves pg_dump header and schema-level/unclassified content.\n\n",
    ]
    schema_file_parts.extend(preamble)

    for section in sections:
        meta = section["meta"]
        obj_type = meta["type"].upper()
        obj_name = meta["name"]
        obj_schema = meta["schema"]
        folder = TYPE_DIR.get(obj_type)

        # Do not duplicate the complete dump into schema.sql. Only collect
        # sections that cannot be safely classified into a dedicated folder.
        if not folder:
            schema_file_parts.append("\n-- Unclassified pg_dump section; inspect before moving.\n")
            schema_file_parts.extend(section["lines"])
            inventory.append({
                "schema": obj_schema, "name": obj_name, "type": meta["type"],
                "file": "schema.sql", "classification": "unclassified"
            })
            continue

        target_dir = schema_dir if folder == "." else schema_dir / folder
        target_dir.mkdir(parents=True, exist_ok=True)
        stem = safe_name(obj_name)
        key = (folder, stem.lower())
        counts[key] = counts.get(key, 0) + 1
        suffix = "" if counts[key] == 1 else f"__{counts[key]:02d}"
        filename = f"{stem}{suffix}.sql"
        target = target_dir / filename

        header = (
            "-- Generated from pg_dump; do not hand-edit this baseline without review.\n"
            f"-- Schema: {obj_schema}\n"
            f"-- Object: {obj_name}\n"
            f"-- Type: {meta['type']}\n\n"
        )
        target.write_text(header + "".join(section["lines"]), encoding="utf-8")
        inventory.append({
            "schema": obj_schema, "name": obj_name, "type": meta["type"],
            "file": str(target.relative_to(schema_dir)).replace("\\", "/"),
            "classification": "mapped"
        })

    (schema_dir / "schema.sql").write_text(
        "".join(schema_file_parts), encoding="utf-8"
    )
    return {
        "objects": inventory,
        "object_count": len(inventory),
        "unclassified_count": sum(1 for x in inventory if x["classification"] == "unclassified"),
    }

def main() -> int:
    parser = argparse.ArgumentParser(description="Export PostgreSQL schemas to per-object SQL files.")
    parser.add_argument("--output", default="schemas", help="Output root directory (default: ./schemas)")
    parser.add_argument("--schema", action="append", help="Export only this schema; repeatable. Default: all non-system schemas.")
    parser.add_argument("--host", default=os.getenv("PGHOST"))
    parser.add_argument("--port", default=os.getenv("PGPORT", "5432"))
    parser.add_argument("--database", default=os.getenv("PGDATABASE"))
    parser.add_argument("--user", default=os.getenv("PGUSER"))
    parser.add_argument("--no-password-prompt", action="store_true", help="Fail if PGPASSWORD is not already set.")
    parser.add_argument("--clean-schema-dir", action="store_true", help="Delete each selected schema output folder before export.")
    args = parser.parse_args()

    for executable in ("psql", "pg_dump"):
        if not shutil.which(executable):
            print(f"ERROR: '{executable}' was not found on PATH. Install PostgreSQL client tools.", file=sys.stderr)
            return 2

    if not args.database or not args.user:
        parser.error("Set PGDATABASE and PGUSER, or pass --database and --user.")
    if not args.host:
        parser.error("Set PGHOST or pass --host.")

    env = os.environ.copy()
    env.update({
        "PGHOST": args.host,
        "PGPORT": str(args.port),
        "PGDATABASE": args.database,
        "PGUSER": args.user,
        "PGCLIENTENCODING": "UTF8",
        "PGCONNECT_TIMEOUT": "15",
    })
    if not env.get("PGPASSWORD"):
        if args.no_password_prompt:
            print("ERROR: PGPASSWORD is not set and --no-password-prompt was specified.", file=sys.stderr)
            return 2
        env["PGPASSWORD"] = read_password()

    try:
        schema_output = run(
            ["psql", "-X", "-A", "-t", "-v", "ON_ERROR_STOP=1", "-c", SCHEMA_QUERY],
            env=env
        )
        discovered = [line.strip() for line in schema_output.splitlines() if line.strip()]
        schemas = args.schema if args.schema else discovered
        unknown = sorted(set(schemas) - set(discovered))
        if unknown:
            raise RuntimeError("Schema(s) not visible or not found: " + ", ".join(unknown))

        output_root = Path(args.output).resolve()
        output_root.mkdir(parents=True, exist_ok=True)
        manifest = {
            "database": args.database,
            "host": args.host,
            "exported_schemas": [],
            "note": "Schema definitions only; no table data. Review object coverage and dependencies before deployment."
        }

        for schema in schemas:
            print(f"[{schema}] Exporting schema-only dump...")
            dump = run([
                "pg_dump", "--schema-only", "--no-owner", "--no-privileges",
                "--schema", schema,
                "--host", args.host, "--port", str(args.port),
                "--username", args.user, "--dbname", args.database,
                "--no-password"
            ], env=env)

            schema_dir = output_root / safe_name(schema)
            if args.clean_schema_dir and schema_dir.exists():
                shutil.rmtree(schema_dir)
            schema_dir.mkdir(parents=True, exist_ok=True)

            result = write_object_files(schema_dir, dump)
            (schema_dir / "inventory.json").write_text(
                json.dumps(result, indent=2, ensure_ascii=False) + "\n",
                encoding="utf-8"
            )
            manifest["exported_schemas"].append({
                "schema": schema,
                "folder": str(schema_dir.relative_to(output_root)).replace("\\", "/"),
                "object_count": result["object_count"],
                "unclassified_count": result["unclassified_count"],
            })
            print(f"  -> {result['object_count']} object sections; "
                  f"{result['unclassified_count']} unclassified section(s)")

        (output_root / "export-manifest.json").write_text(
            json.dumps(manifest, indent=2, ensure_ascii=False) + "\n",
            encoding="utf-8"
        )
        print(f"\nDone. Output: {output_root}")
        print("Review schema.sql and inventory.json files, then commit the output to Git.")
        return 0
    except RuntimeError as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1

if __name__ == "__main__":
    raise SystemExit(main())
