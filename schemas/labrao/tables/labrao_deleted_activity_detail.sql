-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_deleted_activity_detail
-- Type: TABLE

-- Name: labrao_deleted_activity_detail; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_deleted_activity_detail (
    user_id numeric,
    run_id numeric,
    distance numeric(10,4),
    activity_start_time numeric,
    activity_date date,
    verification_flag numeric,
    created_date timestamp without time zone
);


--
