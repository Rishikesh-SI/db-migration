-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_academy
-- Type: TABLE

-- Name: labfg_academy; Type: TABLE; Schema: labfg; Owner: -
--

CREATE TABLE labfg.labfg_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
