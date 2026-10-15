-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_academy
-- Type: TABLE

-- Name: labtri_academy; Type: TABLE; Schema: labtri; Owner: -
--

CREATE TABLE labtri.labtri_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
