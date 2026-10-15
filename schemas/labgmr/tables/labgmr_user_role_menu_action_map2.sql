-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_user_role_menu_action_map2
-- Type: TABLE

-- Name: labgmr_user_role_menu_action_map2; Type: TABLE; Schema: labgmr; Owner: -
--

CREATE TABLE labgmr.labgmr_user_role_menu_action_map2 (
    role_menu_action_id numeric NOT NULL,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
