-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_contact
-- Type: TABLE

-- Name: lablakr_contact; Type: TABLE; Schema: lablakr; Owner: -
--

CREATE TABLE lablakr.lablakr_contact (
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
    mobile_no character varying,
    feedback text,
    dob date,
    gender character varying(1),
    subject text,
    page_flag character varying(2),
    state text,
    city text,
    designation character varying(500),
    oragnisation character varying(1000),
    user_guid character varying(20),
    attachment text,
    contact_json jsonb,
    module text,
    unique_id character varying
);


--
