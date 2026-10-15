-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_user_calendar
-- Type: TABLE

-- Name: isl_user_calendar; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_user_calendar (
    user_calendar_id numeric NOT NULL,
    user_guid character varying(500),
    calendar_id character varying(500),
    team jsonb,
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    type numeric,
    user_id numeric,
    social_cal_id character varying(500),
    refreshtoken character varying(500),
    season_id numeric
);


--
