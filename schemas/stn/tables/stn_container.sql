-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_container
-- Type: TABLE

-- Name: stn_container; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_container (
    container_id numeric NOT NULL,
    container_label character varying(256),
    column_ratio character varying(256),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    container_guid character varying(256),
    order_number numeric,
    image_file_name character varying(2000),
    image_path character varying(4000),
    waf_component_type_id numeric,
    client_id numeric,
    is_custom numeric,
    parent_id numeric,
    is_mobile numeric
);


--
