-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: otp_details
-- Type: TABLE

-- Name: otp_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.otp_details (
    id integer NOT NULL,
    mobile_no character varying(1000),
    email_id character varying(1000),
    otp numeric,
    opt numeric,
    type numeric,
    user_guid character varying(1000),
    is_app numeric,
    count numeric,
    created_date timestamp without time zone DEFAULT now(),
    user_full_name character varying(1000),
    otp_request_count numeric,
    request_ip character varying(1000),
    country_code numeric
);


--
