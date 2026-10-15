-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_web_user_20181120
-- Type: TABLE

-- Name: isl_web_user_20181120; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_web_user_20181120 (
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
    verification_key character varying(4000)
);


--
