-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_user_master
-- Type: TABLE

-- Name: labupstox_user_master; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_user_master (
    user_id numeric NOT NULL,
    email_id text,
    login_password text,
    user_guid text,
    payment_status numeric,
    payment_amount character varying(500),
    category character varying(500),
    pledged_distance character varying(500),
    group_id character varying(500),
    user_name character varying(500),
    city text,
    state_name text,
    pincode text,
    bib_no numeric,
    height character varying(500),
    weight character varying(500),
    mobile_no text,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    external_user_id numeric,
    dob timestamp without time zone,
    charity_amount character varying(500),
    nationality character varying(500),
    gender character varying(50),
    pledged_state character varying(500),
    pledged_city character varying(500),
    group_name character varying(500),
    activity_date date,
    admin_updated_date timestamp without time zone
);


--
