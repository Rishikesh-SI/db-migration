-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_entity_role_map_08032023
-- Type: TABLE

-- Name: labtkr_entity_role_map_08032023; Type: TABLE; Schema: labtkr; Owner: -
--

CREATE TABLE labtkr.labtkr_entity_role_map_08032023 (
    entity_role_map_id numeric,
    entity_role_id numeric,
    entity_master_id numeric,
    priority numeric,
    is_active numeric,
    source_object_id character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    hyperlink numeric,
    tour_id numeric,
    entity_code character varying
);


--
