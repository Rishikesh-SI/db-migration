-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_academy
-- Type: TABLE

-- Name: labgt_academy; Type: TABLE; Schema: labgt_bkp; Owner: -
--

CREATE TABLE labgt_bkp.labgt_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
