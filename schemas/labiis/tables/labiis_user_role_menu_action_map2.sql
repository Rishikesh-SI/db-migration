-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_user_role_menu_action_map2
-- Type: TABLE

-- Name: labiis_user_role_menu_action_map2; Type: TABLE; Schema: labiis; Owner: -
--

CREATE TABLE labiis.labiis_user_role_menu_action_map2 (
    role_menu_action_id numeric,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
