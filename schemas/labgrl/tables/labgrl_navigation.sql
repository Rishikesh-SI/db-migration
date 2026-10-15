-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_navigation
-- Type: TABLE

-- Name: labgrl_navigation; Type: TABLE; Schema: labgrl; Owner: -
--

CREATE TABLE labgrl.labgrl_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
