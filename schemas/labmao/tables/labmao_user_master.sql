-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_user_master
-- Type: TABLE

-- Name: labmao_user_master; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_user_master (
    user_id numeric NOT NULL,
    email_id text,
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
    user_json jsonb,
    pledged_state character varying(500),
    pledged_city character varying(500),
    group_name character varying(500),
    activity_date date,
    admin_updated_date timestamp without time zone,
    old_group_id character varying(500),
    donation_amount character varying(500),
    ticket_amount character varying(500),
    racetee_amount character varying(500),
    medal_amount character varying(500),
    gst_amount character varying(500),
    country character varying(500),
    address character varying(500),
    teesize character varying(500),
    runclub_name character varying(500),
    usr_password text,
    pancard character varying,
    firstname text,
    lastname text,
    ngo text,
    corporate text,
    transaction_no text,
    addons jsonb
);


--
