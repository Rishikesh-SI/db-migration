-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_product_image_map
-- Type: TABLE

-- Name: dd_product_image_map; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_product_image_map (
    product_image_map_id numeric NOT NULL,
    product_id numeric NOT NULL,
    image_id numeric NOT NULL,
    image_order numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    is_cover numeric
);


--
