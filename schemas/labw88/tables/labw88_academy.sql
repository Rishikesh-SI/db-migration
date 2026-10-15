-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_academy
-- Type: TABLE

-- Name: labw88_academy; Type: TABLE; Schema: labw88; Owner: -
--

CREATE TABLE labw88.labw88_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
