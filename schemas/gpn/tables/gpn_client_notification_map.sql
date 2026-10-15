-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_client_notification_map
-- Type: TABLE

-- Name: gpn_client_notification_map; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_client_notification_map (
    client_notification_map_id numeric NOT NULL,
    notification_id character varying(50) NOT NULL,
    league_id numeric NOT NULL,
    client_id numeric NOT NULL,
    notification_text text NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    title character varying(255)
);


--
