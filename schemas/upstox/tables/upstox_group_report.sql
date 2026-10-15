-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_group_report
-- Type: TABLE

-- Name: upstox_group_report; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_group_report (
    group_report_id numeric NOT NULL,
    group_id character varying(500),
    total_distance numeric,
    total_fund numeric,
    total_participation numeric,
    total_pledged_distance numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone,
    total_activity_time numeric,
    curr_rank numeric,
    prev_rank numeric
);


--
