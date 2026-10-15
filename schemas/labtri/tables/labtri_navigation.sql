-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_navigation
-- Type: TABLE

-- Name: labtri_navigation; Type: TABLE; Schema: labtri; Owner: -
--

CREATE TABLE labtri.labtri_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
