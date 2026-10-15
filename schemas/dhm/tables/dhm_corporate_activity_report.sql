-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_corporate_activity_report
-- Type: TABLE

-- Name: dhm_corporate_activity_report; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_corporate_activity_report (
    activity_report_id numeric NOT NULL,
    group_name character varying(500),
    distance numeric(10,4),
    curr_rank numeric,
    prev_rank numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    pledged_distance numeric(10,4),
    total_participation numeric,
    group_id character varying(500)
);


--
