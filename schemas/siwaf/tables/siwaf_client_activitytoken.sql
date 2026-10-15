-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_client_activitytoken
-- Type: TABLE

-- Name: siwaf_client_activitytoken; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_client_activitytoken (
    client_atid numeric NOT NULL,
    client_id text,
    platform text,
    activity_token text,
    device_token text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    input_json jsonb,
    is_flag boolean
);


--
