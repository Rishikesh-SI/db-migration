-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_web_user_10092020
-- Type: TABLE

-- Name: dd_web_user_10092020; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_web_user_10092020 (
    user_id numeric,
    client_id numeric,
    social_user_name character varying(100),
    user_full_name character varying(100),
    email_id character varying(100),
    upper_email_id character varying(100),
    user_password character varying(100),
    social_id character varying(100),
    dob date,
    profile_picture_url character varying(100),
    city character varying(100),
    mobile_no character varying(20),
    user_guid character varying(256),
    reset_key character varying(256),
    key_expiry_date timestamp without time zone,
    reset_key_status numeric,
    old_password character varying(100),
    failed_attempts numeric,
    unlock_date timestamp without time zone,
    user_bio text,
    is_registered numeric,
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    gender character varying(10),
    is_verified numeric,
    country character varying(100),
    country_code numeric,
    auth_token text,
    last_name text,
    first_name text,
    favourite_player_id character varying(500),
    address text,
    last_spin_date timestamp without time zone,
    spin_no numeric,
    favourite_club text,
    epoch_timestamp character varying(256),
    token character varying(2000),
    ipaddress character varying(2000),
    edition character varying(4000),
    is_login numeric,
    verification_key character varying(4000),
    is_custom_image numeric,
    old_profile_image_url character varying(2500)
);


--
