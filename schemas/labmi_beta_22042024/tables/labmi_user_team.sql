-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_user_team
-- Type: TABLE

-- Name: labmi_user_team; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_user_team (
    user_team_id numeric NOT NULL,
    user_id numeric NOT NULL,
    team_json jsonb NOT NULL,
    created_date timestamp without time zone NOT NULL,
    season_id character varying(200),
    week_id numeric,
    updated_date timestamp without time zone
);


--
