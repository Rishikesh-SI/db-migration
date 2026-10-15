-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_contact
-- Type: TABLE

-- Name: labdd_v1_contact; Type: TABLE; Schema: labdd_v1_30april24; Owner: -
--

CREATE TABLE labdd_v1_30april24.labdd_v1_contact (
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
    telephone_number character varying(20),
    attachment text,
    contact_json jsonb
);


--
