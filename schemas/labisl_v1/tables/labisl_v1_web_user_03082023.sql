-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_web_user_03082023
-- Type: TABLE

-- Name: labisl_v1_web_user_03082023; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_web_user_03082023 (
    user_id numeric,
    client_id numeric,
    social_user_name character varying(1000),
    user_full_name character varying(1000),
    email_id character varying(1000),
    upper_email_id character varying(1000),
    user_password character varying(1000),
    social_id character varying(1000),
    dob character varying(1000),
    profile_picture_url character varying(1000),
    city character varying(1000),
    mobile_no character varying(1000),
    user_guid character varying(256),
    reset_key character varying(4000),
    key_expiry_date timestamp without time zone,
    reset_key_status numeric,
    old_password character varying(1000),
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
    gender character varying(1000),
    is_verified numeric,
    favourite_club character varying,
    token character varying(2000),
    epoch_timestamp character varying(256),
    ipaddress character varying(1000),
    edition character varying(4000),
    is_login numeric,
    verification_key character varying(4000),
    is_custom_image numeric,
    old_profile_image_url character varying(2500),
    favourite_player_id character varying(500),
    address text,
    is_profile_complete numeric,
    complete_profile_id numeric,
    country_code character varying,
    first_name character varying,
    last_name character varying,
    membership_code character varying,
    email_verified numeric,
    country_id numeric,
    jersey_number numeric,
    jersey_name character varying,
    city_id numeric,
    state_id numeric,
    subscribe_for_email boolean,
    ext_info jsonb,
    pincode character varying,
    internal_referral_code character varying,
    referal_user_guid character varying,
    is_referred numeric,
    sync_status numeric
);


--
