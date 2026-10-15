-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_player_fan_poll_201718
-- Type: TABLE

-- Name: isl_player_fan_poll_201718; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_player_fan_poll_201718 (
    player_fan_poll_id numeric(38,0),
    match_id character varying(100),
    player_id character varying(100),
    team_id character varying(100),
    votes numeric(38,0),
    season_id character varying(100),
    sport_id character varying(100),
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone,
    created_by numeric(38,0),
    updated_by numeric(38,0),
    is_active numeric(38,0),
    is_deleted numeric(38,0),
    poll_guid character varying(256)
);


--
