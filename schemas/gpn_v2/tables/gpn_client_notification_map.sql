-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_client_notification_map
-- Type: TABLE

-- Name: gpn_client_notification_map; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_client_notification_map (
    client_notification_map_id numeric,
    client_id numeric,
    notification_id numeric,
    notification_title character varying(100),
    notification_text text,
    created_date timestamp without time zone
);


--
