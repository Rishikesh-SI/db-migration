-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_academy
-- Type: TABLE

-- Name: labetpl_academy; Type: TABLE; Schema: labetpl; Owner: -
--

CREATE TABLE labetpl.labetpl_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
