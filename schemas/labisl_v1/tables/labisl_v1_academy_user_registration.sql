-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_academy_user_registration
-- Type: TABLE

-- Name: labisl_v1_academy_user_registration; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_academy_user_registration (
    user_registration_id numeric NOT NULL,
    user_name character varying(256),
    email_id character varying(256),
    parent_name character varying(256),
    contact numeric,
    academy_id numeric,
    frequency numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_guid character varying(256),
    user_data jsonb,
    otp numeric,
    otp_expiry_time timestamp without time zone
);


--
