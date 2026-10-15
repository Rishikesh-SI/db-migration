-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_user_bckup_28july2023
-- Type: TABLE

-- Name: labisl_v1_user_bckup_28july2023; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_user_bckup_28july2023 (
    user_id numeric,
    user_name character varying(300),
    full_name character varying(300),
    display_name character varying(300),
    partner_id character varying(300),
    email_id character varying(300),
    profile_picture_url character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    user_guid character varying(256),
    user_pwd character varying(256),
    reset_key character varying(256),
    key_expiry numeric,
    failed_attempts numeric,
    unlock_date timestamp without time zone,
    bio text,
    social_link_json jsonb,
    is_show_listing numeric,
    image_id numeric,
    image_name text,
    is_password_changed numeric
);


--
