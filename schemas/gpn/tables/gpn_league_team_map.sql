-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_league_team_map
-- Type: TABLE

-- Name: gpn_league_team_map; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_league_team_map (
    league_team_map_id numeric NOT NULL,
    league_id numeric NOT NULL,
    team_id numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
