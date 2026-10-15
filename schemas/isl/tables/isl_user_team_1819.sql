-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_user_team_1819
-- Type: TABLE

-- Name: isl_user_team_1819; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_user_team_1819 (
    user_team_id numeric,
    user_id numeric,
    team_json jsonb,
    created_date timestamp without time zone,
    season_id character varying(200),
    week_id numeric
);


--
