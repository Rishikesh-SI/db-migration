-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_type
-- Type: TABLE

-- Name: labmi_product_type; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_type (
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
