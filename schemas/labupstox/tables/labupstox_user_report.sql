-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_user_report
-- Type: TABLE

-- Name: labupstox_user_report; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_user_report (
    user_report_id numeric NOT NULL,
    user_id numeric,
    total_distance numeric,
    total_fund numeric,
    total_pledged_distance numeric,
    total_activity_time numeric,
    state_name character varying(500),
    group_id character varying(500),
    city_name character varying(500),
    gender character varying(50),
    age numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    prev_rank numeric,
    curr_rank numeric
);


--
