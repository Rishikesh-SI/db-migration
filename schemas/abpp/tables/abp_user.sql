-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_user
-- Type: TABLE

-- Name: abp_user; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_user (
    user_id numeric NOT NULL,
    user_name character varying(300) NOT NULL,
    full_name character varying(300) NOT NULL,
    display_name character varying(300) NOT NULL,
    partner_id character varying(300) NOT NULL,
    email_id character varying(300),
    profile_picture_url character varying(3000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    user_guid character varying(256) NOT NULL,
    user_pwd character varying(256) NOT NULL,
    reset_key character varying(256),
    key_expiry numeric,
    failed_attempts numeric,
    unlock_date timestamp without time zone,
    bio text,
    is_show_listing numeric,
    social_links jsonb,
    image_id numeric,
    image_name character varying,
    is_password_changed numeric
);


--
