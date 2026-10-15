-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_entity_language_map
-- Type: TABLE

-- Name: labkc_v1_entity_language_map; Type: TABLE; Schema: labkc_v1_02042024; Owner: -
--

CREATE TABLE labkc_v1_02042024.labkc_v1_entity_language_map (
    entity_language_map_id numeric NOT NULL,
    entity_master_id numeric,
    language_master_id numeric,
    entity_name character varying(3000),
    entity_display_name text,
    canonical_url text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    wafc_entity_name character varying(3000),
    wafc_entity_display_name character varying(4000)
);


--
