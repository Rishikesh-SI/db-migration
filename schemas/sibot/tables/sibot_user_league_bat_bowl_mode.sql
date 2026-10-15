-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_user_league_bat_bowl_mode
-- Type: TABLE

-- Name: sibot_user_league_bat_bowl_mode; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_user_league_bat_bowl_mode (
    user_league_bat_bowl_mode_id numeric,
    user_id numeric,
    opt_type text,
    league_id numeric,
    alert_status numeric,
    alert_start_date timestamp without time zone,
    alert_stopped_date timestamp without time zone,
    alert_stopped_till timestamp without time zone,
    application_id numeric
);


--
