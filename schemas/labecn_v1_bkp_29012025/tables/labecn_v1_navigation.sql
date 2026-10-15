-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_navigation
-- Type: TABLE

-- Name: labecn_v1_navigation; Type: TABLE; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE TABLE labecn_v1_bkp_29012025.labecn_v1_navigation (
    navigation_id numeric NOT NULL,
    template_comp_map_id numeric[],
    entity_role_map_id numeric[],
    navigation json,
    created_date timestamp without time zone,
    status numeric,
    menu_id numeric[]
);


--
