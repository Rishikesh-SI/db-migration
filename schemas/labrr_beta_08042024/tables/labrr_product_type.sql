-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_product_type
-- Type: TABLE

-- Name: labrr_product_type; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_product_type (
    product_type_id numeric NOT NULL,
    product_type_name character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    product_type_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
