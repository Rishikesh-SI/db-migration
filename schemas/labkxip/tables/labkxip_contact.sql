-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_contact
-- Type: TABLE

-- Name: labkxip_contact; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_contact (
    contact_id numeric NOT NULL,
    name character varying(256),
    email_address character varying(256),
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
    gender character varying,
    subject text,
    page_flag numeric,
    state text,
    city text,
    designation character varying(500),
    oragnisation character varying(1000),
    telephone_number character varying,
    attachment text,
    contact_json jsonb,
    first_name character varying,
    last_name character varying,
    unique_id character varying,
    user_guid character varying
);


--
