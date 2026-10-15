-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_client_event_map
-- Type: TABLE

-- Name: gpn_client_event_map; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_client_event_map (
    client_event_map_id numeric,
    client_id numeric,
    event_id numeric,
    child_event_id numeric,
    subscription_id numeric,
    is_image_available numeric,
    sound_clip text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
