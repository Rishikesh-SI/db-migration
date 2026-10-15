-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_state_report
-- Type: TABLE

-- Name: labrao_state_report; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_state_report (
    state_report_id numeric NOT NULL,
    state_name character varying(500),
    total_distance numeric,
    total_fund numeric,
    total_participation numeric,
    total_pledged_distance numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone,
    total_activity_time numeric,
    prev_rank numeric,
    curr_rank numeric
);


--
