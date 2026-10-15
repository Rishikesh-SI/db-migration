-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_topic_deleted
-- Type: TABLE

-- Name: gpn_topic_deleted; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_topic_deleted (
    topic_id numeric,
    topic_name character varying(50),
    topic_arn character varying(100),
    application_id numeric,
    league_id numeric,
    match_id numeric,
    team_id numeric,
    event_id numeric,
    subscription_id numeric,
    language_id numeric,
    country_id numeric,
    for_admin_notification numeric,
    status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    lookup_values text[]
);


--
