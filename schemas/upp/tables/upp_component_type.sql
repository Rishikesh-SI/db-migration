-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_component_type
-- Type: TABLE

-- Name: upp_component_type; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_component_type (
    component_type_id numeric NOT NULL,
    type_name character varying(256) NOT NULL,
    type_display_name character varying(256) NOT NULL,
    image_file_name character varying(2000),
    image_path character varying(4000),
    component_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    component_type_guid character varying(256),
    order_number numeric NOT NULL,
    waf_component_type_id numeric NOT NULL,
    client_id numeric NOT NULL
);


--
