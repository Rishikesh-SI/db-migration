-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_contact_20180921
-- Type: TABLE

-- Name: jafc_contact_20180921; Type: TABLE; Schema: jafc; Owner: -
--

CREATE TABLE jafc.jafc_contact_20180921 (
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
    mobile_number character varying(20)
);


--
