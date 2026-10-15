-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_academy
-- Type: TABLE

-- Name: labacko_academy; Type: TABLE; Schema: labacko; Owner: -
--

CREATE TABLE labacko.labacko_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
