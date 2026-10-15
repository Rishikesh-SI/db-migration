-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_menu
-- Type: TABLE

-- Name: abp_menu; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_menu (
    menu_id numeric NOT NULL,
    menu_name character varying(1000) NOT NULL,
    display_name character varying(1000) NOT NULL,
    menu_type numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    menu_guid character varying(256),
    is_dynamic numeric NOT NULL,
    max_level numeric,
    include_child_pages numeric NOT NULL
);


--
