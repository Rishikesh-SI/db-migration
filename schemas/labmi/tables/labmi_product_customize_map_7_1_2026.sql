-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_customize_map_7_1_2026
-- Type: TABLE

-- Name: labmi_product_customize_map_7_1_2026; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_customize_map_7_1_2026 (
    product_customize_map_id numeric,
    product_id numeric,
    product_customize_id numeric,
    customize_price numeric,
    is_added_price numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    pcm_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    is_deactivated numeric
);


--
