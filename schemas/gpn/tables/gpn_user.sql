-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_user
-- Type: TABLE

-- Name: gpn_user; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_user (
    user_id numeric NOT NULL,
    device_token character varying(500) NOT NULL,
    application_id numeric NOT NULL,
    language_id numeric NOT NULL,
    notification_enabled numeric NOT NULL,
    device_id character varying(500),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    is_password_changed numeric
);


--
