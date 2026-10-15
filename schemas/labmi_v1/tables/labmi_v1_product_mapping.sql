-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_mapping
-- Type: TABLE

-- Name: labmi_v1_product_mapping; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_mapping (
    product_mapping_id numeric NOT NULL,
    product_category_id numeric,
    product_manufacturer_id numeric,
    stores_limit numeric,
    mapping_json json,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    product_mapping_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
