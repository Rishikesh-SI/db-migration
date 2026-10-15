-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: labecn_menu_page_map
-- Type: TABLE

-- Name: labecn_menu_page_map; Type: TABLE; Schema: labecn_bkp07062024; Owner: -
--

CREATE TABLE labecn_bkp07062024.labecn_menu_page_map (
    menu_page_map_id numeric NOT NULL,
    menu_id numeric,
    page_id numeric,
    title character varying(300),
    page_level numeric,
    upfront numeric,
    parent_page_id numeric,
    order_number numeric,
    no_action numeric,
    external_url character varying(4000),
    function_info text,
    meta_info jsonb,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    mpmap_guid character varying(256)
);


--
