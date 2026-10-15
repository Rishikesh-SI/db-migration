-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_event_slot
-- Type: TABLE

-- Name: dhm_event_slot; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_event_slot (
    slot_id numeric NOT NULL,
    event_user_id numeric,
    session_date date,
    session_slot character varying(500),
    status numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
