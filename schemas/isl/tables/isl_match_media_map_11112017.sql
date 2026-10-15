-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_match_media_map_11112017
-- Type: TABLE

-- Name: isl_match_media_map_11112017; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_match_media_map_11112017 (
    match_media_map_id numeric(38,0),
    match_id numeric(38,0),
    media_id numeric(38,0),
    media_match_map_guid character varying(256),
    is_active numeric(38,0),
    is_deleted numeric(38,0),
    created_by numeric(38,0),
    updated_by numeric(38,0),
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone
);


--
