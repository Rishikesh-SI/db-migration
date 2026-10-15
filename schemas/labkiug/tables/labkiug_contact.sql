-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiug
-- Object: labkiug_contact
-- Type: TABLE

-- Name: labkiug_contact; Type: TABLE; Schema: labkiug; Owner: -
--

CREATE TABLE labkiug.labkiug_contact (
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
    mobile_number character varying(20),
    feedback text
);


--
