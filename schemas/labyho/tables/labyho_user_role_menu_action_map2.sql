-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_user_role_menu_action_map2
-- Type: TABLE

-- Name: labyho_user_role_menu_action_map2; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_user_role_menu_action_map2 (
    role_menu_action_id numeric,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
