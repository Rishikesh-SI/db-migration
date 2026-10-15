-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_navigation
-- Type: TABLE

-- Name: labsaw_navigation; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
