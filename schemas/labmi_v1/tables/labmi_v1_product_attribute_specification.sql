-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_attribute_specification
-- Type: TABLE

-- Name: labmi_v1_product_attribute_specification; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_attribute_specification (
    product_attribute_specification_id numeric NOT NULL,
    product_attribute_id numeric,
    specification_name character varying,
    description character varying(1000),
    pas_json json,
    display_order numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    pas_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    specification_code character varying
);


--
