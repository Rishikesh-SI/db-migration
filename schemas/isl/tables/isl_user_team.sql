-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_user_team
-- Type: TABLE

-- Name: isl_user_team; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_user_team (
    user_team_id numeric NOT NULL,
    user_id numeric NOT NULL,
    team_json jsonb NOT NULL,
    created_date timestamp without time zone NOT NULL,
    season_id character varying(200),
    week_id numeric
);


--
