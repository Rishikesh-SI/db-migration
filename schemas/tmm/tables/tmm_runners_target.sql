-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_runners_target
-- Type: TABLE

-- Name: tmm_runners_target; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_runners_target (
    runner_target_id numeric NOT NULL,
    first_name text,
    last_name text,
    dob date,
    email_id text,
    race_category text,
    target_time text,
    runner_id numeric,
    created_date timestamp without time zone,
    inspired_by text,
    inspired_how text,
    runner_name text,
    entry_flag numeric,
    timing_certificate text,
    user_guid text
);


--
