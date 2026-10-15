-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_academy
-- Type: TABLE

-- Name: labdv_academy; Type: TABLE; Schema: labdv; Owner: -
--

CREATE TABLE labdv.labdv_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
