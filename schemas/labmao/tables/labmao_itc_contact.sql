-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_itc_contact
-- Type: TABLE

-- Name: labmao_itc_contact; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_itc_contact (
    contact_id numeric NOT NULL,
    first_name character varying(256),
    last_name character varying(256),
    email_address character varying(500),
    mobile_number character varying(50),
    created_date timestamp without time zone,
    contact_json jsonb,
    dob date,
    gender text,
    codeno text
);


--
