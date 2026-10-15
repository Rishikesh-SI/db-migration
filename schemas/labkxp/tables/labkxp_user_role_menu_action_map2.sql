-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_user_role_menu_action_map2
-- Type: TABLE

-- Name: labkxp_user_role_menu_action_map2; Type: TABLE; Schema: labkxp; Owner: -
--

CREATE TABLE labkxp.labkxp_user_role_menu_action_map2 (
    role_menu_action_id numeric,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
