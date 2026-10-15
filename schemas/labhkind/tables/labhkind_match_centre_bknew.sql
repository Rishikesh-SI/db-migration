-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_match_centre_bknew
-- Type: TABLE

-- Name: labhkind_match_centre_bknew; Type: TABLE; Schema: labhkind; Owner: -
--

CREATE TABLE labhkind.labhkind_match_centre_bknew (
    match_centre_id numeric(38,0),
    sport_id numeric(38,0),
    series_id numeric(38,0),
    match_id numeric(38,0),
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
    is_active numeric(38,0),
    is_deleted numeric(38,0),
    created_by numeric(38,0),
    updated_by numeric(38,0),
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone,
    leader_board jsonb,
    year text
);


--
