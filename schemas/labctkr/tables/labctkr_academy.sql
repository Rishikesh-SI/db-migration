-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: labctkr_academy
-- Type: TABLE

-- Name: labctkr_academy; Type: TABLE; Schema: labctkr; Owner: -
--

CREATE TABLE labctkr.labctkr_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
