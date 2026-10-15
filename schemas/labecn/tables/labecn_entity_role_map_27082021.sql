-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_entity_role_map_27082021
-- Type: TABLE

-- Name: labecn_entity_role_map_27082021; Type: TABLE; Schema: labecn; Owner: -
--

CREATE TABLE labecn.labecn_entity_role_map_27082021 (
    entity_role_map_id numeric,
    entity_role_id numeric,
    entity_master_id numeric,
    priority numeric,
    is_active numeric,
    source_object_id character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    hyperlink numeric,
    tour_id text,
    league_id text
);


--
