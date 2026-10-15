-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_contact
-- Type: TABLE

-- Name: utt_contact; Type: TABLE; Schema: utt; Owner: -
--

CREATE TABLE utt.utt_contact (
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
    mobile_number character varying(20) NOT NULL,
    feedback text
);


--
