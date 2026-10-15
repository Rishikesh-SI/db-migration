-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: labwafdemo_academy
-- Type: TABLE

-- Name: labwafdemo_academy; Type: TABLE; Schema: labwafdemo; Owner: -
--

CREATE TABLE labwafdemo.labwafdemo_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
