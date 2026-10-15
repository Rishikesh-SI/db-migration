-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_academy
-- Type: TABLE

-- Name: labyho_academy; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
