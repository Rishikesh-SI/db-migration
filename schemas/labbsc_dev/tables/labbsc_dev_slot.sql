-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_slot
-- Type: TABLE

-- Name: labbsc_dev_slot; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_slot (
    slot_id numeric NOT NULL,
    session_slot character varying(500),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active numeric DEFAULT 1,
    start_time character varying(50)
);


--
