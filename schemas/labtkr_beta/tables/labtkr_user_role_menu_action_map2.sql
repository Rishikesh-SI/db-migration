-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_user_role_menu_action_map2
-- Type: TABLE

-- Name: labtkr_user_role_menu_action_map2; Type: TABLE; Schema: labtkr_beta; Owner: -
--

CREATE TABLE labtkr_beta.labtkr_user_role_menu_action_map2 (
    role_menu_action_id numeric NOT NULL,
    role_id numeric,
    user_menu_id numeric,
    user_action_id numeric,
    is_active numeric,
    created_date timestamp without time zone
);


--
