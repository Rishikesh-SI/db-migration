-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_pkl
-- Type: TABLE

-- Name: gpn_user_pkl; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_user_pkl (
    user_id numeric NOT NULL,
    device_token text NOT NULL,
    device_id text,
    application_id numeric NOT NULL,
    language_id numeric NOT NULL,
    is_notification_enabled numeric DEFAULT 0 NOT NULL,
    country_id numeric DEFAULT 1 NOT NULL,
    app_version text,
    token_change_counter numeric DEFAULT 0 NOT NULL,
    call_json jsonb,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    is_active numeric DEFAULT 1 NOT NULL,
    is_deleted numeric DEFAULT 0 NOT NULL,
    endpoint_arn text
);


--
