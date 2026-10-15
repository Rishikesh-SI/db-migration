-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_corporate_activity_report
-- Type: TABLE

-- Name: labtcs_corporate_activity_report; Type: TABLE; Schema: labtcs; Owner: -
--

CREATE TABLE labtcs.labtcs_corporate_activity_report (
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
