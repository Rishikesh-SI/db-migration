-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_entity_map
-- Type: TABLE

-- Name: sibot_application_entity_map; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_entity_map (
    application_event_map_id numeric,
    application_id numeric,
    entity_id numeric,
    entity_priority numeric,
    event_id numeric
);


--
