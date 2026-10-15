-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_menu
-- Type: TABLE

-- Name: labgt_menu; Type: TABLE; Schema: labgt_bkp; Owner: -
--

CREATE TABLE labgt_bkp.labgt_menu (
    menu_id numeric NOT NULL,
    menu_name character varying(1000),
    display_name character varying(1000),
    menu_type numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    menu_guid character varying(256),
    is_dynamic numeric,
    max_level numeric,
    include_child_pages numeric,
    language_id numeric,
    required_entities numeric[]
);


--
