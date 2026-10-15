-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_menu_action_25_08_2020
-- Type: TABLE

-- Name: siwaf_menu_action_25_08_2020; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_menu_action_25_08_2020 (
    menu_action_id numeric,
    action_name text,
    action_display_name text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    status_flg numeric,
    parent_id numeric[],
    ordring numeric
);


--
