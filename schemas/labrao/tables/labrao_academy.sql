-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_academy
-- Type: TABLE

-- Name: labrao_academy; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
