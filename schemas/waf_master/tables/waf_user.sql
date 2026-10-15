-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_user
-- Type: TABLE

-- Name: waf_user; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_user (
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
    key_expiry_date timestamp without time zone,
    failed_attempts numeric,
    unlock_date timestamp without time zone,
    bio text,
    is_password_changed numeric
);


--
