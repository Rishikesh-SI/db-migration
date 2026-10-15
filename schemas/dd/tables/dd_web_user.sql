-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_web_user
-- Type: TABLE

-- Name: dd_web_user; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_web_user (
    user_id numeric NOT NULL,
    client_id numeric NOT NULL,
    social_user_name character varying(1000),
    user_full_name character varying(1000),
    email_id character varying(1000),
    upper_email_id character varying(1000),
    user_password character varying(100),
    social_id text,
    dob character varying(1000),
    profile_picture_url character varying(1000),
    city character varying(1000),
    mobile_no character varying(1000),
    user_guid character varying(256) NOT NULL,
    reset_key character varying(256),
    key_expiry_date timestamp without time zone,
    reset_key_status numeric,
    old_password character varying(100),
    failed_attempts numeric,
    unlock_date timestamp without time zone,
    user_bio text,
    is_registered numeric,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    gender character varying(1000),
    is_verified numeric,
    country character varying(100),
    country_code numeric,
    auth_token text,
    favourite_club text,
    token character varying(2000),
    epoch_timestamp character varying(256),
    ipaddress character varying(2000),
    edition character varying(4000),
    is_login numeric,
    verification_key character varying(4000),
    is_custom_image numeric,
    old_profile_image_url character varying(2500),
    first_name text,
    last_name text,
    favourite_player_id character varying(500),
    address text,
    last_spin_date timestamp without time zone,
    spin_no numeric
);


--
