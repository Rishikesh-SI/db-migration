-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_entity_group
-- Type: TABLE

-- Name: cli_stp_v1_entity_group; Type: TABLE; Schema: cli_stp_v1; Owner: -
--

CREATE TABLE cli_stp_v1.cli_stp_v1_entity_group (
    entity_group_id numeric NOT NULL,
    waf_entity_group_id numeric,
    client_id numeric,
    group_name character varying(300),
    group_desc character varying(2000),
    created_date timestamp without time zone,
    update_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_child numeric
);


--
