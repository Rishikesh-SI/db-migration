-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_navigation
-- Type: TABLE

-- Name: lablakr_navigation; Type: TABLE; Schema: lablakr; Owner: -
--

CREATE TABLE lablakr.lablakr_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
