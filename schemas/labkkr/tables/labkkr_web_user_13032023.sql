-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_web_user_13032023
-- Type: TABLE

-- Name: labkkr_web_user_13032023; Type: TABLE; Schema: labkkr; Owner: -
--

CREATE TABLE labkkr.labkkr_web_user_13032023 (
    user_id numeric NOT NULL,
    client_id numeric NOT NULL,
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
    user_guid character varying(256) NOT NULL,
    reset_key character varying(4000),
    key_expiry_date timestamp without time zone,
    reset_key_status numeric,
    old_password character varying(1000),
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
    first_name character varying(1000),
    last_name character varying(1000),
    jersey_number numeric,
    subscribe_for_email boolean,
    membership_code character varying,
    whatsapp_consent character varying(300)
);


--
