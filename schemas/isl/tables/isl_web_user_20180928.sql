-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_web_user_20180928
-- Type: TABLE

-- Name: isl_web_user_20180928; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_web_user_20180928 (
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
    is_verified numeric
);


--
