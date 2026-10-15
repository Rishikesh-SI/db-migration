-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: labecn_entity_role_map
-- Type: TABLE

-- Name: labecn_entity_role_map; Type: TABLE; Schema: labecn_bkp05092024; Owner: -
--

CREATE TABLE labecn_bkp05092024.labecn_entity_role_map (
    entity_role_map_id numeric NOT NULL,
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
