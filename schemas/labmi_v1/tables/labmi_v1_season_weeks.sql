-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_season_weeks
-- Type: TABLE

-- Name: labmi_v1_season_weeks; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_season_weeks (
    season_week_id numeric,
    season_id character varying(200),
    week_id numeric,
    week_name text,
    week_start_date timestamp without time zone,
    week_end_date timestamp without time zone,
    is_active numeric
);


--
