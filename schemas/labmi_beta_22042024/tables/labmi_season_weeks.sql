-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_season_weeks
-- Type: TABLE

-- Name: labmi_season_weeks; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_season_weeks (
    season_week_id numeric,
    season_id character varying(200),
    week_id numeric,
    week_name text,
    week_start_date timestamp without time zone,
    week_end_date timestamp without time zone,
    is_active numeric
);


--
