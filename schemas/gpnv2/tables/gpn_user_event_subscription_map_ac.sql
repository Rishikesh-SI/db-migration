-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_event_subscription_map_ac
-- Type: TABLE

-- Name: gpn_user_event_subscription_map_ac; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_user_event_subscription_map_ac (
    user_event_subscription_map_id numeric NOT NULL,
    user_id numeric NOT NULL,
    application_id numeric NOT NULL,
    league_id numeric NOT NULL,
    event_id numeric NOT NULL,
    subscription_id numeric NOT NULL,
    data_value_id numeric NOT NULL,
    data_value character varying(50),
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    lookup_value text[],
    series_id numeric,
    match_source_id character varying(500)
);


--
