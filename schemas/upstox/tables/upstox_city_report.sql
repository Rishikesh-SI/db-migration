-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_city_report
-- Type: TABLE

-- Name: upstox_city_report; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_city_report (
    city_report_id numeric NOT NULL,
    city_name character varying(500),
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
