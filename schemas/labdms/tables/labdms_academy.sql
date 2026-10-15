-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_academy
-- Type: TABLE

-- Name: labdms_academy; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
