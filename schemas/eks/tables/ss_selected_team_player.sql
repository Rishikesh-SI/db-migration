-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_selected_team_player
-- Type: TABLE

-- Name: ss_selected_team_player; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_selected_team_player (
    cf_teamid numeric,
    cf_tourid numeric(25,0) NOT NULL,
    team_name character varying,
    team_short_name character varying,
    cf_playerid numeric(25,0) NOT NULL,
    cf_skillid numeric(10,0) NOT NULL,
    cf_player_categoryid numeric(10,0) NOT NULL,
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
