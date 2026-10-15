-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_customize
-- Type: TABLE

-- Name: labmi_v1_product_customize; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_customize (
    product_customize_id numeric NOT NULL,
    customize_name character varying,
    description character varying(1000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    customize_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    custmize_prize numeric
);


--
