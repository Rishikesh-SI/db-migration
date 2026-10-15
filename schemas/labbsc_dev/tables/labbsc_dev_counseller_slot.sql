-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_counseller_slot
-- Type: TABLE

-- Name: labbsc_dev_counseller_slot; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_counseller_slot (
    slot_id numeric NOT NULL,
    counseller_user_id numeric,
    session_date date,
    session_slot character varying(500),
    status numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
