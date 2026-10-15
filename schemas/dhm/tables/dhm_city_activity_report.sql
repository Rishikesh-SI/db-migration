-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_city_activity_report
-- Type: TABLE

-- Name: dhm_city_activity_report; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_city_activity_report (
    activity_report_id numeric NOT NULL,
    city character varying(500),
    distance numeric(10,4),
    curr_rank numeric,
    prev_rank numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    total_participation numeric,
    state_name character varying(500),
    pledged_distance numeric(10,4)
);


--
