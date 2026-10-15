-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_container
-- Type: TABLE

-- Name: abp_container; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_container (
    container_id numeric NOT NULL,
    container_label character varying(256) NOT NULL,
    column_ratio character varying(256) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    container_guid character varying(256),
    order_number numeric NOT NULL,
    image_file_name character varying(2000),
    image_path character varying(4000),
    waf_component_type_id numeric NOT NULL,
    client_id numeric NOT NULL,
    is_custom numeric NOT NULL,
    parent_id numeric,
    is_mobile numeric
);


--
