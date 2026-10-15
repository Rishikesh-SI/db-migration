-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_user_menu_bk
-- Type: TABLE

-- Name: siwaf_user_menu_bk; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_user_menu_bk (
    user_menu_id numeric,
    menu_name text,
    menu_display_name text,
    parent_id numeric,
    menu_level numeric,
    menu_ord numeric,
    is_active numeric,
    created_date timestamp without time zone,
    css_class text,
    redirect_url text,
    is_visible numeric
);


--
