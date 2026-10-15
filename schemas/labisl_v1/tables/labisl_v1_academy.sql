-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_academy
-- Type: TABLE

-- Name: labisl_v1_academy; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
