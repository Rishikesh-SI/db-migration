-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_entity_language_map_newbk
-- Type: TABLE

-- Name: swa_entity_language_map_newbk; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_entity_language_map_newbk (
    entity_language_map_id numeric NOT NULL,
    entity_master_id numeric NOT NULL,
    language_master_id numeric NOT NULL,
    entity_name character varying(3000) NOT NULL,
    entity_display_name text,
    canonical_url text,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    wafc_entity_name character varying(3000) NOT NULL,
    wafc_entity_display_name character varying(4000)
);


--
