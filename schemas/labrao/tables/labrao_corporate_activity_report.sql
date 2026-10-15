-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_corporate_activity_report
-- Type: TABLE

-- Name: labrao_corporate_activity_report; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_corporate_activity_report (
    activity_report_id numeric NOT NULL,
    group_name character varying(500),
    distance numeric(10,6),
    curr_rank numeric,
    prev_rank numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    pledged_distance numeric(10,4),
    total_participation numeric,
    group_id character varying(500)
);


--
