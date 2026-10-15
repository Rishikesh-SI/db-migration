-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_language_master
-- Type: TABLE

-- Name: swa_language_master; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_language_master (
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
