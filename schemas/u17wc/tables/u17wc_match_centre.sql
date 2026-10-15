-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_match_centre
-- Type: TABLE

-- Name: u17wc_match_centre; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_match_centre (
    match_centre_id numeric NOT NULL,
    sport_id numeric,
    series_id numeric,
    match_id numeric,
    match_source_object_id character varying(100),
    match_title character varying(500),
    match_ticket_url character varying(500),
    league_ticket_url character varying(500),
    live_stream_embed_code_source character varying(100),
    live_stream_embed_code character varying(500),
    live_stream_url_source character varying(100),
    live_stream_url character varying(500),
    match_hashtag character varying(100),
    social_info character varying(500),
    match_day_battle jsonb,
    match_centre_guid character varying(256),
    match_centre_json jsonb,
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    leader_board jsonb
);


--
