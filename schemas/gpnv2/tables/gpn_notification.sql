-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_notification
-- Type: TABLE

-- Name: gpn_notification; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_notification (
    notification_id numeric NOT NULL,
    notification_unique_id character varying(20) NOT NULL,
    notification_title text,
    notification_text text,
    notification_image_id character varying(10),
    notification_json jsonb NOT NULL,
    league_id numeric NOT NULL,
    match_id numeric NOT NULL,
    team_a_id numeric NOT NULL,
    team_b_id numeric NOT NULL,
    trigger_id numeric NOT NULL,
    event_id numeric NOT NULL,
    language_id numeric NOT NULL,
    status numeric DEFAULT 0 NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL
);


--
