-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_user_role_menu_action_map2
-- Type: TABLE

-- Name: labw88_user_role_menu_action_map2; Type: TABLE; Schema: labw88; Owner: -
--

CREATE TABLE labw88.labw88_user_role_menu_action_map2 (
    role_menu_action_id numeric NOT NULL,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
