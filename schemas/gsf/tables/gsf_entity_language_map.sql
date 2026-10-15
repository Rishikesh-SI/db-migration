-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_entity_language_map
-- Type: TABLE

-- Name: gsf_entity_language_map; Type: TABLE; Schema: gsf; Owner: -
--

CREATE TABLE gsf.gsf_entity_language_map (
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
