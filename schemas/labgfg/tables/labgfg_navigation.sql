-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_navigation
-- Type: TABLE

-- Name: labgfg_navigation; Type: TABLE; Schema: labgfg; Owner: -
--

CREATE TABLE labgfg.labgfg_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
