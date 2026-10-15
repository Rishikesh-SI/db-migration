-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: labecn_academy
-- Type: TABLE

-- Name: labecn_academy; Type: TABLE; Schema: labecn_bkp05092024; Owner: -
--

CREATE TABLE labecn_bkp05092024.labecn_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
