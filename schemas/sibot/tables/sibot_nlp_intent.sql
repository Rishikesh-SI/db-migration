-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_nlp_intent
-- Type: TABLE

-- Name: sibot_nlp_intent; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_nlp_intent (
    intent_id numeric,
    intent_name text,
    entity_name text,
    event_id numeric,
    default_event_id numeric
);


--
