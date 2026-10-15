-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_category
-- Type: TABLE

-- Name: labmi_v1_product_category; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_category (
    product_category_id numeric NOT NULL,
    category_name character varying,
    description text,
    parent_category_id numeric,
    display_order numeric,
    price_range numeric,
    is_show_homepage numeric,
    is_top_menu numeric,
    is_select_pagesize numeric,
    page_size_option character varying(100),
    discount numeric,
    customer_role_id numeric,
    limit_per_store numeric,
    category_json json,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    category_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
