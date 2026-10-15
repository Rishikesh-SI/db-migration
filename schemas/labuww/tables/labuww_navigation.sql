-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_navigation
-- Type: TABLE

-- Name: labuww_navigation; Type: TABLE; Schema: labuww; Owner: -
--

CREATE TABLE labuww.labuww_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
