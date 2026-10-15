-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_league_team_map
-- Type: TABLE

-- Name: gpn_league_team_map; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_league_team_map (
    league_team_map_id numeric NOT NULL,
    league_id numeric NOT NULL,
    team_id numeric NOT NULL
);


--
