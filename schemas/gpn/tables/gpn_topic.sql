-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_topic
-- Type: TABLE

-- Name: gpn_topic; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_topic (
    topic_id numeric NOT NULL,
    topic_name character varying(100) NOT NULL,
    topic_arn character varying(100) NOT NULL,
    application_id numeric NOT NULL,
    league_id numeric NOT NULL,
    match_id numeric NOT NULL,
    team_id numeric NOT NULL,
    event_id numeric NOT NULL,
    subscription_id numeric NOT NULL,
    language_id numeric NOT NULL,
    status numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
