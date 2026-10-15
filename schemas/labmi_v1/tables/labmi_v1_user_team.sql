-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_user_team
-- Type: TABLE

-- Name: labmi_v1_user_team; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_user_team (
    user_team_id numeric NOT NULL,
    user_id numeric,
    team_json jsonb,
    created_date timestamp without time zone,
    season_id character varying(200),
    week_id numeric,
    updated_date timestamp without time zone,
    match_id character varying
);


--
