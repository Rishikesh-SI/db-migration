-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_attribute_specification_7_1_2026
-- Type: TABLE

-- Name: labmi_product_attribute_specification_7_1_2026; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_attribute_specification_7_1_2026 (
    product_attribute_specification_id numeric,
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
