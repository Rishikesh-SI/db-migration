-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_client_comment_source_map
-- Type: TABLE

-- Name: siwaf_client_comment_source_map; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_client_comment_source_map (
    client_comment_source_map_id numeric,
    client_code character varying(10),
    source_id numeric,
    source_value numeric,
    priority numeric
);


--
