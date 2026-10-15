-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_user
-- Type: TABLE

-- Name: u17wc_user; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_user (
    user_id numeric NOT NULL,
    user_name character varying(300),
    full_name character varying(300),
    display_name character varying(300),
    partner_id character varying(300),
    email_id character varying(300),
    profile_picture_url character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    user_guid character varying(256),
    user_pwd character varying(256),
    reset_key character varying(256),
    key_expiry_date timestamp without time zone,
    failed_attempts numeric,
    unlock_date timestamp without time zone,
    bio text,
    is_password_changed numeric
);


--
