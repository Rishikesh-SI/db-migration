-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_user_master_24082020
-- Type: TABLE

-- Name: labmao_user_master_24082020; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_user_master_24082020 (
    user_id numeric,
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
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    external_user_id numeric,
    dob timestamp without time zone,
    charity_amount character varying(500),
    nationality character varying(500),
    gender character varying(50),
    user_json jsonb,
    pledged_state character varying(500),
    pledged_city character varying(500),
    group_name character varying(500),
    activity_date date,
    admin_updated_date timestamp without time zone
);


--
