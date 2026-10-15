-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_notification_payload
-- Type: TABLE

-- Name: gpn_notification_payload; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_notification_payload (
    notification_payload_id numeric NOT NULL,
    notification_id character varying(20) NOT NULL,
    notification_payload jsonb,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
