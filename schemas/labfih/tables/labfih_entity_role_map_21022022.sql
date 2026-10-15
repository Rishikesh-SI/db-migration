-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_entity_role_map_21022022
-- Type: TABLE

-- Name: labfih_entity_role_map_21022022; Type: TABLE; Schema: labfih; Owner: -
--

CREATE TABLE labfih.labfih_entity_role_map_21022022 (
    entity_role_map_id numeric,
    entity_role_id numeric,
    entity_master_id numeric,
    priority numeric,
    is_active numeric,
    source_object_id character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    hyperlink numeric,
    tour_id numeric
);


--
