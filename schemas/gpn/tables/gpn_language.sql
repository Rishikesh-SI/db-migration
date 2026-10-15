-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_language
-- Type: TABLE

-- Name: gpn_language; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_language (
    language_id numeric NOT NULL,
    language_name character varying(100) NOT NULL,
    language_code character varying(5) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
