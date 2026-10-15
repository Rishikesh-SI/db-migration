-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_contact
-- Type: TABLE

-- Name: labdsg_contact; Type: TABLE; Schema: labdsg; Owner: -
--

CREATE TABLE labdsg.labdsg_contact (
    contact_id numeric NOT NULL,
    name character varying(256),
    email_address character varying,
    address character varying(1024),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    mobile_number character varying,
    feedback text,
    dob date,
    gender character varying(1),
    subject text,
    page_flag numeric,
    state text,
    city text,
    country_code character varying(500),
    oragnisation character varying(1000),
    captcha character varying,
    attachment text,
    contact_json jsonb,
    first_name character varying,
    last_name character varying
);


--
