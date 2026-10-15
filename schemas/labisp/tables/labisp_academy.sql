-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_academy
-- Type: TABLE

-- Name: labisp_academy; Type: TABLE; Schema: labisp; Owner: -
--

CREATE TABLE labisp.labisp_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
