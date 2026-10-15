-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_product_customize
-- Type: TABLE

-- Name: dd_product_customize; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_product_customize (
    product_customize_id numeric NOT NULL,
    customize_name character varying NOT NULL,
    description character varying(1000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    customize_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    custmize_prize numeric
);


--
