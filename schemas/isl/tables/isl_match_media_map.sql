-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_match_media_map
-- Type: TABLE

-- Name: isl_match_media_map; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_match_media_map (
    match_media_map_id numeric(38,0) NOT NULL,
    match_id numeric(38,0) NOT NULL,
    media_id numeric(38,0) NOT NULL,
    media_match_map_guid character varying(256),
    is_active numeric(38,0) DEFAULT 1 NOT NULL,
    is_deleted numeric(38,0) DEFAULT 0 NOT NULL,
    created_by numeric(38,0) DEFAULT 1 NOT NULL,
    updated_by numeric(38,0) DEFAULT 1 NOT NULL,
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone
);


--
