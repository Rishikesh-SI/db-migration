-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_slot
-- Type: TABLE

-- Name: dhm_slot; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_slot (
    slot_id numeric,
    session_slot character varying(500),
    created_date timestamp without time zone,
    is_active numeric,
    start_time character varying(50)
);


--
