-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_product_type
-- Type: TABLE

-- Name: dd_product_type; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_product_type (
    product_type_id numeric NOT NULL,
    product_type_name character varying NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    product_type_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
