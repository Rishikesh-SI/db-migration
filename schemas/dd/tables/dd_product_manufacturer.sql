-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_product_manufacturer
-- Type: TABLE

-- Name: dd_product_manufacturer; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_product_manufacturer (
    product_manufacturer_id numeric NOT NULL,
    manufacturer_name character varying NOT NULL,
    description text,
    display_order numeric,
    price_range numeric,
    is_show_homepage numeric,
    is_top_menu numeric,
    is_select_pagesize numeric,
    page_size_option character varying(100),
    discount numeric,
    customer_role_id numeric,
    limit_per_store numeric,
    manufacturer_json json,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    manufacturer_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
