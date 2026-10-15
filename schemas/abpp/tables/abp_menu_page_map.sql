-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_menu_page_map
-- Type: TABLE

-- Name: abp_menu_page_map; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_menu_page_map (
    menu_page_map_id numeric NOT NULL,
    menu_id numeric NOT NULL,
    page_id numeric NOT NULL,
    title character varying(300),
    page_level numeric NOT NULL,
    upfront numeric NOT NULL,
    parent_page_id numeric,
    order_number numeric NOT NULL,
    no_action numeric NOT NULL,
    external_url character varying(4000),
    is_sub_menu numeric NOT NULL,
    meta_info jsonb,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    mpmap_guid character varying(256)
);


--
