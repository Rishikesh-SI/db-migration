-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_nlp_entity_intent_event_map
-- Type: TABLE

-- Name: sibot_application_nlp_entity_intent_event_map; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_nlp_entity_intent_event_map (
    application_nlp_entity_intent_event_map_id numeric,
    application_id numeric,
    entity_id numeric,
    intent_id numeric,
    event_id numeric
);


--
