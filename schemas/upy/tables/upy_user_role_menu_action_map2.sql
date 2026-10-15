-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_user_role_menu_action_map2
-- Type: TABLE

-- Name: upy_user_role_menu_action_map2; Type: TABLE; Schema: upy; Owner: -
--

CREATE TABLE upy.upy_user_role_menu_action_map2 (
    role_menu_action_id numeric,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
