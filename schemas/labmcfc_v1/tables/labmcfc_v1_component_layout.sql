-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_component_layout
-- Type: TABLE

-- Name: labmcfc_v1_component_layout; Type: TABLE; Schema: labmcfc_v1; Owner: -
--

CREATE TABLE labmcfc_v1.labmcfc_v1_component_layout (
    component_layout_id numeric NOT NULL,
    ref_number character varying(1000),
    layout_name character varying(1000),
    layout_display_name character varying(1000),
    layout_desc character varying(2000),
    component_type_id numeric,
    component_id numeric,
    image_file_name character varying(2000),
    image_path character varying(4000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    component_layout_guid character varying(256),
    order_number numeric,
    is_responsive numeric,
    waf_component_layout_id numeric,
    client_id numeric,
    parent_id numeric,
    mobile_image_file_name character varying(2000),
    mobile_image_path character varying(4000)
);


--
