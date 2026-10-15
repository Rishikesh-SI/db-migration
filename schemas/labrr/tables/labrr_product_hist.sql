-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_product_hist
-- Type: TABLE

-- Name: labrr_product_hist; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_product_hist (
    product_id numeric,
    product_name character varying(1000),
    product_title character varying(1000),
    title_alias character varying,
    short_desc text,
    description text,
    product_type_id numeric,
    product_code character varying,
    product_price numeric,
    is_visible_individually numeric,
    gtin_number character varying(100),
    manufacturer_part_number character varying(100),
    is_show_homepage numeric,
    is_allow_customer_review numeric,
    available_start_date timestamp without time zone,
    available_end_date timestamp without time zone,
    discounts numeric,
    is_fix_percentage numeric,
    is_tax_exempt numeric,
    tax_category numeric,
    product_json json,
    is_mark_new numeric,
    is_shipping_enabled numeric,
    admin_comment character varying(4000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    product_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    is_trashed numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    published_date timestamp without time zone,
    published_version_number numeric,
    audit_date timestamp without time zone
);


--
