-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_contact
-- Type: TABLE

-- Name: hsl_contact; Type: TABLE; Schema: hsl; Owner: -
--

CREATE TABLE hsl.hsl_contact (
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
    mobile_number character varying(20) DEFAULT 1234567890 NOT NULL
);


--
