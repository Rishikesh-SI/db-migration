-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_match_media_map
-- Type: TABLE

-- Name: u17wc_match_media_map; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_match_media_map (
    match_media_map_id numeric NOT NULL,
    match_id numeric,
    media_id numeric,
    media_match_map_guid character varying(256),
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
