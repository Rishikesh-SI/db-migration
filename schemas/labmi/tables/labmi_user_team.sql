-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_user_team
-- Type: TABLE

-- Name: labmi_user_team; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_user_team (
    user_team_id numeric NOT NULL,
    user_id numeric NOT NULL,
    team_json jsonb NOT NULL,
    created_date timestamp without time zone NOT NULL,
    season_id character varying(200),
    week_id numeric,
    updated_date timestamp without time zone,
    match_id character varying
);


--
