-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_event_widget_map
-- Type: TABLE

-- Name: sibot_application_event_widget_map; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_event_widget_map (
    application_event_widget_map_id numeric,
    application_id numeric,
    event_id numeric,
    parent_event_id numeric,
    widget_id numeric,
    event_order numeric,
    is_active numeric,
    image_attachment_id text
);


--
