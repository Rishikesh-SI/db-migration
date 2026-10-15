-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_send_notification
-- Type: TABLE

-- Name: siwaf_send_notification; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_send_notification (
    notification_data_id numeric NOT NULL,
    client_name character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    notification_json json,
    notification_id character varying,
    title character varying,
    asset_type character varying,
    campaign_id character varying,
    not_mssg character varying
);


--
