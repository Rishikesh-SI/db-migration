-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_slot
-- Type: TABLE

-- Name: labbsc_slot; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_slot (
    slot_id numeric NOT NULL,
    session_slot character varying(500),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active numeric DEFAULT 1,
    start_time character varying(50)
);


--
