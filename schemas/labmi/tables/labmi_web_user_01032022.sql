-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_web_user_01032022
-- Type: TABLE

-- Name: labmi_web_user_01032022; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_web_user_01032022 (
    user_id numeric,
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
    ipaddress character varying,
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
    is_mail_sent numeric,
    survey_emails_status numeric,
    mail_sent_date timestamp without time zone,
    trans_guid character varying(256),
    unsubscribe numeric,
    campaign_id numeric,
    otp numeric,
    mobile_verified numeric,
    otp_expired_time timestamp without time zone,
    membership_start_date timestamp without time zone,
    attempt numeric,
    attempt_date timestamp without time zone,
    whatsapp_consent numeric,
    platform_id numeric,
    old_campaign_id numeric
);


--
