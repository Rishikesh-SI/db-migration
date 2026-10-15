-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_contact_22012018
-- Type: TABLE

-- Name: isl_contact_22012018; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_contact_22012018 (
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
    feedback text
);


--
