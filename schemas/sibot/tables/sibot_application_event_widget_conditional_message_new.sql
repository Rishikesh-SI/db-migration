-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_event_widget_conditional_message_new
-- Type: TABLE

-- Name: sibot_application_event_widget_conditional_message_new; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_event_widget_conditional_message_new (
    application_event_widget_conditional_message_id numeric,
    application_id numeric,
    event_id numeric,
    widget_id numeric,
    condition_id numeric,
    message_text text,
    message_order numeric
);


--
