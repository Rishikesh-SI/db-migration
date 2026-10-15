-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_user_team_2005
-- Type: TABLE

-- Name: labmi_user_team_2005; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_user_team_2005 (
    user_team_id numeric,
    user_id numeric,
    team_json jsonb,
    created_date timestamp without time zone,
    season_id character varying(200),
    week_id numeric,
    updated_date timestamp without time zone
);


--
