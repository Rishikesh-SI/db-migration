-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_notification
-- Type: TABLE

-- Name: gpn_notification; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_notification (
    notification_id numeric,
    notification_unique_id character varying(50),
    notification_title character varying(100),
    notification_text text,
    notification_image_id character varying(50),
    notification_json jsonb,
    league_id numeric,
    match_id numeric,
    team_a_id numeric,
    team_b_id numeric,
    trigger_id numeric,
    event_id numeric,
    language_id numeric,
    status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
