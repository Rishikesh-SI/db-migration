-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_product_mapping
-- Type: TABLE

-- Name: dd_product_mapping; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_product_mapping (
    product_mapping_id numeric NOT NULL,
    product_category_id numeric NOT NULL,
    product_manufacturer_id numeric NOT NULL,
    stores_limit numeric,
    mapping_json json,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    product_mapping_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
