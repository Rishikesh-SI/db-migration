-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_flowix_teams
-- Type: TABLE

-- Name: labyho_flowix_teams; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_flowix_teams (
    team_name character varying(100),
    twitter_handle character varying(200),
    source_object_id text,
    scream_name character varying(100)
);


--
