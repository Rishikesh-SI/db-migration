-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_user_activity_master
-- Type: TABLE

-- Name: labupstox_user_activity_master; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_user_activity_master (
    user_activity_id numeric NOT NULL,
    user_id numeric,
    email_id text,
    activity_date date,
    activity_time character varying(500),
    distance numeric(10,6),
    created_date timestamp without time zone DEFAULT now(),
    bib_no numeric,
    updated_date timestamp without time zone,
    run_id numeric,
    runner_id numeric,
    datasource character varying(500),
    activity_link text,
    activity_start_time character varying(500),
    activity_start_time_epoch timestamp without time zone
);


--
