-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_user_role_menu_action_map2
-- Type: TABLE

-- Name: isl_user_role_menu_action_map2; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_user_role_menu_action_map2 (
    role_menu_action_id numeric NOT NULL,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
