-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_academy
-- Type: TABLE

-- Name: labsrk_academy; Type: TABLE; Schema: labsrk; Owner: -
--

CREATE TABLE labsrk.labsrk_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
