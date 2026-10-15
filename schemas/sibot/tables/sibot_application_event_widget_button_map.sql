-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_event_widget_button_map
-- Type: TABLE

-- Name: sibot_application_event_widget_button_map; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_event_widget_button_map (
    application_event_widget_button_map_id numeric,
    application_id numeric,
    event_id numeric,
    widget_id numeric,
    button_order numeric,
    button_title text,
    button_payload_text text,
    button_template_id numeric,
    is_active numeric,
    payload_event_id numeric,
    button_url text
);


--
