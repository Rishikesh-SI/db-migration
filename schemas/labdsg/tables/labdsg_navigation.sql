-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_navigation
-- Type: TABLE

-- Name: labdsg_navigation; Type: TABLE; Schema: labdsg; Owner: -
--

CREATE TABLE labdsg.labdsg_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
