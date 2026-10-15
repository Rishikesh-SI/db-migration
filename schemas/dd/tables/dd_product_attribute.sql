-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_product_attribute
-- Type: TABLE

-- Name: dd_product_attribute; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_product_attribute (
    product_attribute_id numeric NOT NULL,
    attribute_name character varying NOT NULL,
    description text,
    product_attribute_json json,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    attribute_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
