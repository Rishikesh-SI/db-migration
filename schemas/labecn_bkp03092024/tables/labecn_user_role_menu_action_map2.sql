-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp03092024
-- Object: labecn_user_role_menu_action_map2
-- Type: TABLE

-- Name: labecn_user_role_menu_action_map2; Type: TABLE; Schema: labecn_bkp03092024; Owner: -
--

CREATE TABLE labecn_bkp03092024.labecn_user_role_menu_action_map2 (
    role_menu_action_id numeric,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
