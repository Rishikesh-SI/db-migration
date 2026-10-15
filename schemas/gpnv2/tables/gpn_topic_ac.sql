-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_topic_ac
-- Type: TABLE

-- Name: gpn_topic_ac; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_topic_ac (
    topic_id numeric NOT NULL,
    topic_name character varying(50) NOT NULL,
    topic_arn character varying(100),
    application_id numeric NOT NULL,
    league_id numeric NOT NULL,
    match_id numeric NOT NULL,
    team_id numeric NOT NULL,
    event_id numeric NOT NULL,
    subscription_id numeric NOT NULL,
    language_id numeric NOT NULL,
    country_id numeric NOT NULL,
    for_admin_notification numeric NOT NULL,
    status numeric NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    lookup_values text[]
);


--
