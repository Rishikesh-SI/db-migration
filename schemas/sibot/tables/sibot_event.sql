-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_event
-- Type: TABLE

-- Name: sibot_event; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_event (
    event_id numeric,
    event_name text,
    event_payload text,
    module_id numeric,
    check_event_change numeric
);


--
