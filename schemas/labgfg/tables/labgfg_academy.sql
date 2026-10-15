-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_academy
-- Type: TABLE

-- Name: labgfg_academy; Type: TABLE; Schema: labgfg; Owner: -
--

CREATE TABLE labgfg.labgfg_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
