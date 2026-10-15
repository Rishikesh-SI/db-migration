-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_season_weeks_bak
-- Type: TABLE

-- Name: isl_season_weeks_bak; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_season_weeks_bak (
    season_week_id numeric,
    season_id character varying(200),
    week_id numeric,
    week_name text,
    week_start_date timestamp without time zone,
    week_end_date timestamp without time zone,
    is_active numeric
);


--
