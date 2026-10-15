-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_user_activity_detail
-- Type: TABLE

-- Name: labmao_user_activity_detail; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_user_activity_detail (
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
    state_name character varying(500),
    city character varying(500),
    dob timestamp without time zone,
    gender character varying(50),
    group_name character varying(500),
    activity_start_time_epoch timestamp without time zone,
    verification_flag numeric,
    type text
);


--
