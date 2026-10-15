-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_tour_player
-- Type: TABLE

-- Name: ss_tour_player; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_tour_player (
    cf_playerid numeric(25,0) NOT NULL,
    cf_tourid numeric(25,0) NOT NULL,
    cf_skillid numeric(10,0) NOT NULL,
    cf_player_categoryid numeric(10,0) NOT NULL,
    team_id numeric(25,0),
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    played_matches numeric,
    total_runs numeric(50,0),
    highest_score numeric(50,0),
    average numeric(30,0),
    strike_rate numeric(30,0),
    century numeric(30,0),
    fifty numeric(30,0),
    past_teamid numeric(50,0),
    total_wickets numeric(30,0),
    best_bowling character varying,
    economy numeric(30,0),
    total_four numeric(30,0),
    total_six numeric(30,0),
    total_catches numeric(30,0),
    stumping numeric(30,0),
    three_wicket_haul numeric(30,0),
    cf_tournamentid numeric,
    raid_points numeric,
    raid_strike_rate numeric,
    tackle_points numeric,
    tackle_strike_rate numeric
);


--
