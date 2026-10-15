-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_client
-- Type: TABLE

-- Name: waf_client; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_client (
    client_id numeric NOT NULL,
    client_name character varying(50) NOT NULL,
    client_display_name character varying(50) NOT NULL,
    is_master numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    client_end_point character varying(4000) NOT NULL,
    client_port_number numeric NOT NULL,
    client_database_name character varying(50) NOT NULL,
    client_schema_name character varying(50) NOT NULL,
    client_prefix character varying(20) NOT NULL,
    client_guid character varying(256) NOT NULL,
    client_code character varying NOT NULL,
    bootstrap_version numeric,
    client_json jsonb,
    domain_url text,
    client_wid_num numeric
);


--
