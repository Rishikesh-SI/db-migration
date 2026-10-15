-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_bat_bowl_mode
-- Type: TABLE

-- Name: sibot_application_bat_bowl_mode; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_bat_bowl_mode (
    application_bat_bowl_mode_id numeric,
    application_id numeric,
    opt_type text,
    image_url text,
    is_active numeric,
    message_text text
);


--
