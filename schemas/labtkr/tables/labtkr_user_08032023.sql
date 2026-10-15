-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_user_08032023
-- Type: TABLE

-- Name: labtkr_user_08032023; Type: TABLE; Schema: labtkr; Owner: -
--

CREATE TABLE labtkr.labtkr_user_08032023 (
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
    is_password_changed numeric,
    user_code character varying
);


--
