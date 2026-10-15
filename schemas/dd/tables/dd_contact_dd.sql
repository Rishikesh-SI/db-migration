-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_contact_dd
-- Type: TABLE

-- Name: dd_contact_dd; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_contact_dd (
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
    mobile_number character varying(20),
    feedback text,
    dob timestamp(4) without time zone,
    gender character varying(1)
);


--
