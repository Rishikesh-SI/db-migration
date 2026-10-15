-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_contact_06032023
-- Type: TABLE

-- Name: labrr_contact_06032023; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_contact_06032023 (
    contact_id numeric,
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
    dob character varying(1000),
    gender character varying,
    subject text,
    page_flag numeric,
    state text,
    city text,
    designation character varying(500),
    oragnisation character varying(1000),
    telephone_number character varying(20),
    attachment text,
    contact_json jsonb,
    user_guid character varying(256)
);


--
