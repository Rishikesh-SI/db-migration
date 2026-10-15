-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_contact
-- Type: TABLE

-- Name: rfg_contact; Type: TABLE; Schema: rfg; Owner: -
--

CREATE TABLE rfg.rfg_contact (
    contact_id numeric NOT NULL,
    name character varying(256),
    email_arfgress character varying(256),
    arfgress character varying(1024),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    mobile_number character varying(20),
    feedback text,
    dob date,
    gender character varying(1)
);


--
