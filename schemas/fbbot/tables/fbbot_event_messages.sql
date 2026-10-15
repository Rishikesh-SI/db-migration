-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_event_messages
-- Type: TABLE

-- Name: fbbot_event_messages; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_event_messages (
    event_message_id numeric NOT NULL,
    message_text text,
    message_image_url text,
    event_id numeric,
    parent_id numeric,
    ordering numeric,
    message_json jsonb,
    is_active numeric
);


--
