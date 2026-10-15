-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_language
-- Type: TABLE

-- Name: gpn_language; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_language (
    language_id numeric NOT NULL,
    language_name character varying(100),
    language_code character varying(5)
);


--
