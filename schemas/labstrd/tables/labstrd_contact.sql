-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_contact
-- Type: TABLE

-- Name: labstrd_contact; Type: TABLE; Schema: labstrd; Owner: -
--

CREATE TABLE labstrd.labstrd_contact (
    contact_id numeric NOT NULL,
    name character varying(256),
    email_alabstrdress character varying(256),
    alabstrdress character varying(1024),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    mobile_number character varying(20),
    feedback text,
    dob date,
    gender character varying(1),
    subject text,
    page_flag numeric,
    state text,
    city text,
    designation character varying(500),
    oragnisation character varying(1000),
    telephone_number character varying(20),
    attachment text,
    contact_json jsonb
);


--
