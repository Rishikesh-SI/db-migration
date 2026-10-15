-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_entities_temp
-- Type: TABLE

-- Name: labstmp_entities_temp; Type: TABLE; Schema: labstmp; Owner: -
--

CREATE TABLE labstmp.labstmp_entities_temp (
    entity_type character varying(10),
    entity_name character varying(50),
    sport character varying(10),
    entity_type_id numeric,
    sport_id numeric,
    entity_role_id numeric,
    entity_master_id numeric,
    entity_role_map_id numeric
);


--
