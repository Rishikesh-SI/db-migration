-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_deleted_activity_detail
-- Type: TABLE

-- Name: labirao_deleted_activity_detail; Type: TABLE; Schema: labirao; Owner: -
--

CREATE TABLE labirao.labirao_deleted_activity_detail (
    user_id numeric,
    run_id numeric,
    distance numeric(10,4),
    activity_start_time numeric,
    activity_date date,
    verification_flag numeric,
    created_date timestamp without time zone
);


--
