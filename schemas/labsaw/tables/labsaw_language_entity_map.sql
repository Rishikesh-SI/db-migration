-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_language_entity_map
-- Type: TABLE

-- Name: labsaw_language_entity_map; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_language_entity_map (
    language_master_id numeric,
    language_entity_role_map_id numeric,
    entity_master_id numeric,
    entity_role_map_id numeric,
    entity_name text,
    entity_display_name text,
    entity_image_path text,
    entity_image_file_name text,
    entity_description text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    status numeric
);


--
