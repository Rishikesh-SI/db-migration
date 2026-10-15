-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_user_pkl
-- Type: TABLE

-- Name: gpn_user_pkl; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_user_pkl (
    user_id numeric,
    device_token text,
    device_id text,
    application_id numeric,
    language_id numeric,
    country_id numeric,
    ga_code text,
    notification_enabled numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    is_password_changed numeric
);


--
