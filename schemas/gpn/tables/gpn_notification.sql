-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_notification
-- Type: TABLE

-- Name: gpn_notification; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_notification (
    notification_id numeric NOT NULL,
    notification_text text NOT NULL,
    league_id numeric NOT NULL,
    match_id numeric NOT NULL,
    team_a_id numeric NOT NULL,
    team_b_id numeric NOT NULL,
    trigger_id character varying(50) NOT NULL,
    event_id numeric NOT NULL,
    language_id numeric NOT NULL,
    status numeric NOT NULL,
    unique_id character varying(20) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    title character varying(255),
    object_image_id character varying
);


--
