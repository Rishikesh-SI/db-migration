-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_kid_journey
-- Type: TABLE

-- Name: stn_kid_journey; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_kid_journey (
    kid_journey_id numeric NOT NULL,
    kid_id numeric NOT NULL,
    dimension_detail_id numeric NOT NULL,
    points numeric NOT NULL,
    log_date timestamp without time zone NOT NULL
);


--
