-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_client_notification
-- Type: TABLE

-- Name: siwaf_client_notification; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_client_notification (
    client_code character varying(10),
    client_name character varying(100),
    notification_configuration jsonb
);


--
