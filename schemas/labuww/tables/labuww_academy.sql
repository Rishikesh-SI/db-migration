-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_academy
-- Type: TABLE

-- Name: labuww_academy; Type: TABLE; Schema: labuww; Owner: -
--

CREATE TABLE labuww.labuww_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
