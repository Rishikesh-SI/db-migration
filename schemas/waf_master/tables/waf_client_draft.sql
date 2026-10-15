-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_client_draft
-- Type: TABLE

-- Name: waf_client_draft; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_client_draft (
    client_draft_id numeric NOT NULL,
    client_id numeric,
    client_display_name character varying,
    client_schema_name character varying,
    client_prefix character varying,
    bootstrap_version numeric,
    client_json jsonb,
    domain_url character varying,
    version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    client_draft_guid character varying(256)
);


--
