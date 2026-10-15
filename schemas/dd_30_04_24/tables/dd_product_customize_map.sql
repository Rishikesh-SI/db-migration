-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_product_customize_map
-- Type: TABLE

-- Name: dd_product_customize_map; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_product_customize_map (
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
