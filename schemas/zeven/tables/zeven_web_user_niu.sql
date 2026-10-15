-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_web_user_niu
-- Type: TABLE

-- Name: zeven_web_user_niu; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_web_user_niu (
    user_id numeric NOT NULL,
    social_id character varying(250) NOT NULL,
    client_id numeric(20,0) NOT NULL,
    full_name character varying(256) NOT NULL,
    user_name character varying(200),
    email_id character varying(256),
    city_id numeric,
    state_id numeric,
    country_id numeric,
    image_url character varying(2000),
    mobile_no numeric,
    is_active numeric,
    user_guid character varying(4000),
    created_date timestamp(0) without time zone DEFAULT now(),
    updated_date timestamp(0) without time zone DEFAULT now(),
    is_registered numeric DEFAULT 0,
    dob timestamp(0) without time zone,
    gender character varying(10),
    is_verified numeric DEFAULT 0
);


--
