-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_academy
-- Type: TABLE

-- Name: labgmr_academy; Type: TABLE; Schema: labgmr; Owner: -
--

CREATE TABLE labgmr.labgmr_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
