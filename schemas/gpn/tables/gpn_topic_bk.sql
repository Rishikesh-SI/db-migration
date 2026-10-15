-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_topic_bk
-- Type: TABLE

-- Name: gpn_topic_bk; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_topic_bk (
    topic_id numeric,
    topic_name character varying(100),
    topic_arn character varying(100),
    application_id numeric,
    league_id numeric,
    match_id numeric,
    team_id numeric,
    event_id numeric,
    subscription_id numeric,
    language_id numeric,
    status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
