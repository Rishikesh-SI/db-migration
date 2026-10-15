-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_language_master
-- Type: TABLE

-- Name: upp_language_master; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_language_master (
    language_master_id numeric NOT NULL,
    language_code character varying(30) NOT NULL,
    title character varying(150) NOT NULL,
    title_native character varying(150) NOT NULL,
    sef character varying(150) NOT NULL,
    image character varying(150) NOT NULL,
    description character varying(2000) NOT NULL,
    published numeric NOT NULL,
    ordering numeric NOT NULL
);


--
