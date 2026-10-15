-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_academy
-- Type: TABLE

-- Name: labman_academy; Type: TABLE; Schema: labman; Owner: -
--

CREATE TABLE labman.labman_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
