-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_academy
-- Type: TABLE

-- Name: labfih_academy; Type: TABLE; Schema: labfih; Owner: -
--

CREATE TABLE labfih.labfih_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
