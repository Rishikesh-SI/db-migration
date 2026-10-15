-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labmao_academy_user_registration
-- Type: TABLE

-- Name: labmao_academy_user_registration; Type: TABLE; Schema: labmao_bkp; Owner: -
--

CREATE TABLE labmao_bkp.labmao_academy_user_registration (
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
