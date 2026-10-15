-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_academy
-- Type: TABLE

-- Name: labwis_academy; Type: TABLE; Schema: labwis; Owner: -
--

CREATE TABLE labwis.labwis_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
