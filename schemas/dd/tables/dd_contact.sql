-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_contact
-- Type: TABLE

-- Name: dd_contact; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_contact (
    contact_id numeric NOT NULL,
    name character varying(256) NOT NULL,
    email_address character varying(256) NOT NULL,
    address character varying(1024),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    mobile_number character varying(20) DEFAULT 1234567890,
    feedback text,
    dob timestamp(4) without time zone,
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
