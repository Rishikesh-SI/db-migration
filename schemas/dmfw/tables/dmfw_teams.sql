-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dmfw
-- Object: dmfw_teams
-- Type: TABLE

-- Name: dmfw_teams; Type: TABLE; Schema: dmfw; Owner: -
--

CREATE TABLE dmfw.dmfw_teams (
    team_id numeric NOT NULL,
    team_name character varying(100) NOT NULL,
    team_code character varying(10) NOT NULL
);


--
