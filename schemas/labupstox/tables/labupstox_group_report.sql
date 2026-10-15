-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_group_report
-- Type: TABLE

-- Name: labupstox_group_report; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_group_report (
    group_report_id numeric NOT NULL,
    group_id character varying(500),
    total_distance numeric,
    total_fund numeric,
    total_participation numeric,
    total_pledged_distance numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    total_activity_time numeric,
    curr_rank numeric,
    prev_rank numeric
);


--
