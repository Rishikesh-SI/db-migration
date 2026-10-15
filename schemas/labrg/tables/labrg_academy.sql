-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_academy
-- Type: TABLE

-- Name: labrg_academy; Type: TABLE; Schema: labrg; Owner: -
--

CREATE TABLE labrg.labrg_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
