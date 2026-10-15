-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_events
-- Type: TABLE

-- Name: fbbot_events; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_events (
    event_id numeric NOT NULL,
    event_name text NOT NULL,
    json_template jsonb,
    parent_id numeric,
    is_active numeric,
    payload_text text
);


--
