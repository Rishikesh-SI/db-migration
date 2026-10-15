-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_client_event_subscription_map
-- Type: TABLE

-- Name: gpn_client_event_subscription_map; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_client_event_subscription_map (
    client_event_subscription_map_id numeric NOT NULL,
    client_id numeric,
    event_id numeric,
    child_event_id numeric,
    subscription_id numeric,
    is_image_available numeric,
    sound_clip text,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL
);


--
