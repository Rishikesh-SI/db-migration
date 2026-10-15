-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_academy
-- Type: TABLE

-- Name: labupw_academy; Type: TABLE; Schema: labupw; Owner: -
--

CREATE TABLE labupw.labupw_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
