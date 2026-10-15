-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_web_user
-- Type: TABLE

-- Name: labetpl_web_user; Type: TABLE; Schema: labetpl; Owner: -
--

CREATE TABLE labetpl.labetpl_web_user (
    user_id numeric NOT NULL,
    client_id numeric,
    social_user_name character varying(1000),
    user_full_name character varying(1000),
    email_id character varying(1000),
    upper_email_id character varying(1000),
    user_password character varying(100),
    social_id character varying(100),
    dob character varying(1000),
    profile_picture_url character varying(1000),
    city character varying(1000),
    mobile_no character varying(1000),
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
    gender character varying(1000),
    is_verified numeric,
    country character varying(100),
    country_code numeric,
    auth_token text,
    favourite_club text,
    token character varying(2000),
    epoch_timestamp character varying(256),
    edition character varying(4000),
    is_login numeric,
    verification_key character varying(4000),
    is_custom_image numeric,
    old_profile_image_url character varying(2500),
    city_id numeric,
    state_id numeric,
    country_id numeric,
    is_profile_complete numeric,
    complete_profile_id numeric,
    ipaddress character varying(1000),
    first_name character varying,
    last_name character varying,
    is_shared_data numeric,
    is_used_data numeric,
    ext_info jsonb,
    membership_code character varying,
    is_ind numeric,
    mobile_verified numeric,
    jersey_number numeric,
    pincode character varying,
    favourite_player_id character varying,
    jersey_name character varying,
    subscribe_for_email boolean,
    sync_status numeric,
    accept_tnc boolean
);


--
