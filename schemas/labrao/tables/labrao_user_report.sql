-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_user_report
-- Type: TABLE

-- Name: labrao_user_report; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_user_report (
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
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone,
    prev_rank numeric,
    curr_rank numeric
);


--
