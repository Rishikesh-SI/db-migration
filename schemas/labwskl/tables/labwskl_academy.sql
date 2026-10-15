-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_academy
-- Type: TABLE

-- Name: labwskl_academy; Type: TABLE; Schema: labwskl; Owner: -
--

CREATE TABLE labwskl.labwskl_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
