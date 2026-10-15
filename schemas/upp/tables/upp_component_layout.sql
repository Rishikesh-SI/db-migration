-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_component_layout
-- Type: TABLE

-- Name: upp_component_layout; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_component_layout (
    component_layout_id numeric NOT NULL,
    ref_number character varying(1000) NOT NULL,
    layout_name character varying(1000) NOT NULL,
    layout_display_name character varying(1000) NOT NULL,
    layout_desc character varying(2000),
    component_type_id numeric NOT NULL,
    component_id numeric NOT NULL,
    image_file_name character varying(2000),
    image_path character varying(4000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    component_layout_guid character varying(256),
    order_number numeric NOT NULL,
    is_responsive numeric NOT NULL,
    waf_component_layout_id numeric NOT NULL,
    client_id numeric NOT NULL,
    parent_id numeric,
    mobile_image_file_name character varying(2000),
    mobile_image_path character varying(4000)
);


--
