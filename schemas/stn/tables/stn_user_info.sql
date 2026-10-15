-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_user_info
-- Type: TABLE

-- Name: stn_user_info; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_user_info (
    user_id numeric NOT NULL,
    user_name character varying(100),
    user_password character varying(100),
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email_id character varying(100),
    gender character varying(1) NOT NULL,
    mobile_no character varying(20),
    dob date,
    state_id numeric,
    city_id numeric,
    region text,
    age_category text,
    is_kid numeric NOT NULL,
    parent_id numeric,
    is_verified numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    user_guid character varying(256) NOT NULL
);


--
