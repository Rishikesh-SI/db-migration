-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_user_activity_detail
-- Type: TABLE

-- Name: labtcs_user_activity_detail; Type: TABLE; Schema: labtcs; Owner: -
--

CREATE TABLE labtcs.labtcs_user_activity_detail (
    activity_detail_id numeric NOT NULL,
    email_id text,
    user_name character varying(500),
    user_id numeric,
    bib_no numeric,
    kilometer_covered character varying(500),
    start_lat text,
    start_long text,
    end_lat text,
    end_long text,
    time_taken character varying(500),
    run_date date,
    run_start_time character varying(500),
    run_end_time character varying(500),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone,
    category character varying(500),
    gender character varying(10),
    dob timestamp without time zone,
    country character varying(500),
    run_club_name character varying(500),
    distance numeric(10,4),
    city character varying(500),
    state_name character varying(500),
    group_name character varying(500),
    group_id character varying(500),
    state_id numeric,
    age numeric
);


--
