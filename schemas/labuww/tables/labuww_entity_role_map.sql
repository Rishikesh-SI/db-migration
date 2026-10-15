-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_entity_role_map
-- Type: TABLE

-- Name: labuww_entity_role_map; Type: TABLE; Schema: labuww; Owner: -
--

CREATE TABLE labuww.labuww_entity_role_map (
    entity_role_map_id numeric NOT NULL,
    entity_role_id numeric,
    entity_master_id numeric,
    priority numeric,
    is_active numeric,
    source_object_id character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    hyperlink numeric,
    tour_id numeric,
    ref_id numeric,
    ref_guid character varying
);


--
