-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_player_fan_poll
-- Type: TABLE

-- Name: u17wc_player_fan_poll; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_player_fan_poll (
    player_fan_poll_id numeric NOT NULL,
    match_id character varying(100),
    player_id character varying(100),
    team_id character varying(100),
    votes numeric,
    season_id character varying(100),
    sport_id character varying(100),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    poll_guid character varying(256)
);


--
