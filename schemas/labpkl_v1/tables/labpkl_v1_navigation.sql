-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_navigation
-- Type: TABLE

-- Name: labpkl_v1_navigation; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
