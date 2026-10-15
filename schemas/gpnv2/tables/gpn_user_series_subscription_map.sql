-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_series_subscription_map
-- Type: TABLE

-- Name: gpn_user_series_subscription_map; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_user_series_subscription_map (
    user_event_subscription_map_id numeric,
    user_id numeric,
    application_id numeric,
    league_id numeric,
    event_id numeric,
    subscription_id numeric,
    data_value_id numeric,
    data_value character varying(50),
    created_date timestamp without time zone,
    lookup_value text[]
);


--
