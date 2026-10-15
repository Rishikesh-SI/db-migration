-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_admin_delete_user
-- Type: TABLE

-- Name: labbsc_dev_admin_delete_user; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_admin_delete_user (
    user_id numeric,
    client_id numeric,
    social_user_name character varying(1000),
    user_full_name character varying(1000),
    email_id character varying(1000),
    upper_email_id character varying(1000),
    user_password character varying(1000),
    social_id character varying(1000),
    dob text,
    profile_picture_url character varying(1000),
    city character varying(1000),
    mobile_no text,
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
    job_id numeric[],
    first_name character varying(1000),
    last_name character varying(1000),
    general_emailer_sent_date timestamp without time zone,
    is_emailer_sent numeric,
    sports_vertical character varying,
    sporting_event_inspired_you character varying,
    campaign_name character varying(500),
    module_name character varying(500),
    partner_name text,
    is_university numeric,
    university_code text,
    custom_json jsonb,
    service character varying,
    ext_info jsonb
);


--
