-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_city_report
-- Type: TABLE

-- Name: labupstox_city_report; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_city_report (
    city_report_id numeric NOT NULL,
    city_name character varying(500),
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
