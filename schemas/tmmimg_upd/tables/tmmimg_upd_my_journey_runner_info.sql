-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_my_journey_runner_info
-- Type: TABLE

-- Name: tmmimg_upd_my_journey_runner_info; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_my_journey_runner_info (
    bib_no numeric,
    first_name text,
    last_name text,
    race text,
    runner_json jsonb,
    runner_guid text,
    email_id text,
    new_on numeric,
    send_mail numeric
);


--
