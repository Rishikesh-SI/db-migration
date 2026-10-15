-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_runners_target
-- Type: TABLE

-- Name: tmmimg_upd_runners_target; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_runners_target (
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
    user_guid character varying(300)
);


--
