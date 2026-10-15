-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_navigation
-- Type: TABLE

-- Name: labrr_navigation; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
