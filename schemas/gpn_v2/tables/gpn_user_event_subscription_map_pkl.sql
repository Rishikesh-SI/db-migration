-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_user_event_subscription_map_pkl
-- Type: TABLE

-- Name: gpn_user_event_subscription_map_pkl; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_user_event_subscription_map_pkl (
    user_event_subscription_map_id numeric,
    user_id numeric,
    application_id numeric,
    league_id numeric,
    event_id numeric,
    subscription_id numeric,
    data_value numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
