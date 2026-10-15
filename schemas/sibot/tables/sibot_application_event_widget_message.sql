-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_event_widget_message
-- Type: TABLE

-- Name: sibot_application_event_widget_message; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_event_widget_message (
    application_event_widget_message_id numeric,
    application_id numeric,
    event_id numeric,
    message_text text,
    image_url text,
    message_order numeric,
    is_active numeric,
    message_sub_text text,
    widget_id numeric,
    main_status numeric
);


--
