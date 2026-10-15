-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_attribute_specification
-- Type: TABLE

-- Name: labmi_product_attribute_specification; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_attribute_specification (
    product_attribute_specification_id numeric NOT NULL,
    product_attribute_id numeric NOT NULL,
    specification_name character varying NOT NULL,
    description character varying(1000),
    pas_json json,
    display_order numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    pas_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    specification_code character varying
);


--
