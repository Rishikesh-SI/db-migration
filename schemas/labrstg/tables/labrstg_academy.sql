-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_academy
-- Type: TABLE

-- Name: labrstg_academy; Type: TABLE; Schema: labrstg; Owner: -
--

CREATE TABLE labrstg.labrstg_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
