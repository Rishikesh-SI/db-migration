-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_user
-- Type: TABLE

-- Name: sibot_user; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_user (
    user_id numeric,
    receiver_id text,
    application_id numeric,
    created_date timestamp without time zone,
    first_name text,
    last_name text,
    profile_picture text,
    gender text,
    time_zone text,
    mobile_number text,
    email_id text,
    is_password_changed numeric
);


--
