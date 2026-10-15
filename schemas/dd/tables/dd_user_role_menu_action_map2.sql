-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_user_role_menu_action_map2
-- Type: TABLE

-- Name: dd_user_role_menu_action_map2; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_user_role_menu_action_map2 (
    role_menu_action_id numeric,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
