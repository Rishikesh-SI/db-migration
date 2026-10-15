-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_navigation
-- Type: TABLE

-- Name: labgt01_v1_navigation; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
