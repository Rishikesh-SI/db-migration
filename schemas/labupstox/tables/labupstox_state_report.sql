-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_state_report
-- Type: TABLE

-- Name: labupstox_state_report; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_state_report (
    state_report_id numeric NOT NULL,
    state_name character varying(500),
    total_distance numeric,
    total_fund numeric,
    total_participation numeric,
    total_pledged_distance numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    total_activity_time numeric,
    prev_rank numeric,
    curr_rank numeric
);


--
