-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_player_fan_poll_20171030
-- Type: TABLE

-- Name: isl_player_fan_poll_20171030; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_player_fan_poll_20171030 (
    player_fan_poll_id numeric,
    match_id numeric,
    player_id numeric,
    team_id numeric,
    votes numeric,
    season_id numeric,
    sport_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    poll_guid character varying(256)
);


--
