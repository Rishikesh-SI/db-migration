-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_component_type
-- Type: TABLE

-- Name: cli_stp_v1_component_type; Type: TABLE; Schema: cli_stp_v1; Owner: -
--

CREATE TABLE cli_stp_v1.cli_stp_v1_component_type (
    component_type_id numeric NOT NULL,
    type_name character varying(256),
    type_display_name character varying(256),
    image_file_name character varying(2000),
    image_path character varying(4000),
    component_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    component_type_guid character varying(256),
    order_number numeric,
    waf_component_type_id numeric,
    client_id numeric
);


--
