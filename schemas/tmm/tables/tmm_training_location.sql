-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_training_location
-- Type: TABLE

-- Name: tmm_training_location; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_training_location (
    srno numeric,
    city character varying(100),
    location character varying(1000),
    start_time character varying(20),
    end_time character varying(20),
    days character varying(200)
);


--
