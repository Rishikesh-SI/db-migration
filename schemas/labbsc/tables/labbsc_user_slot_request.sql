-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_slot_request
-- Type: TABLE

-- Name: labbsc_user_slot_request; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_user_slot_request (
    slot_request_id numeric NOT NULL,
    counseller_user_id numeric,
    user_id numeric,
    session_date date,
    session_slot character varying(500),
    status numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
