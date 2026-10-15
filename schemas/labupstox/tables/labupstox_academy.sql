-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_academy
-- Type: TABLE

-- Name: labupstox_academy; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
