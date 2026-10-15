-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_user_role_menu_action_map2
-- Type: TABLE

-- Name: labgmr_user_role_menu_action_map2; Type: TABLE; Schema: labgmr_01082024; Owner: -
--

CREATE TABLE labgmr_01082024.labgmr_user_role_menu_action_map2 (
    role_menu_action_id numeric NOT NULL,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
