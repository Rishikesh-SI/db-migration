-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_client_notification_map
-- Type: TABLE

-- Name: gpn_client_notification_map; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_client_notification_map (
    client_notification_map_id numeric NOT NULL,
    client_id numeric NOT NULL,
    notification_id numeric NOT NULL,
    notification_title text,
    notification_text text NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    operation_type numeric
);


--
