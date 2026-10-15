-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_language
-- Type: TABLE

-- Name: gpn_language; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_language (
    language_id numeric NOT NULL,
    language_name character varying(20) NOT NULL,
    language_code character varying(5) NOT NULL
);


--
