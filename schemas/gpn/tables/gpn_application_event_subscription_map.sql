-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_application_event_subscription_map
-- Type: TABLE

-- Name: gpn_application_event_subscription_map; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_application_event_subscription_map (
    application_event_subscription_map_id numeric NOT NULL,
    application_id numeric NOT NULL,
    event_id numeric NOT NULL,
    subscription_id numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
