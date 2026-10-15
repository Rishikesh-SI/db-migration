-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_navigation
-- Type: TABLE

-- Name: labw88_navigation; Type: TABLE; Schema: labw88; Owner: -
--

CREATE TABLE labw88.labw88_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
