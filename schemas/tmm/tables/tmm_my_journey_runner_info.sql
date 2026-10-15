-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_my_journey_runner_info
-- Type: TABLE

-- Name: tmm_my_journey_runner_info; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_my_journey_runner_info (
    bib_no numeric,
    first_name text,
    last_name text,
    race text,
    runner_json jsonb,
    runner_guid text
);


--
