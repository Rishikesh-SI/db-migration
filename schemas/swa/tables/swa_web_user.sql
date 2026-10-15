-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_web_user
-- Type: TABLE

-- Name: swa_web_user; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_web_user (
    user_id numeric NOT NULL,
    client_id numeric NOT NULL,
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
    gender character varying(10),
    is_verified numeric
);


--
