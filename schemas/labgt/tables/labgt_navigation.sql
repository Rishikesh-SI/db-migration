-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_navigation
-- Type: TABLE

-- Name: labgt_navigation; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
