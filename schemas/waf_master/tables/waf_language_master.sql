-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_language_master
-- Type: TABLE

-- Name: waf_language_master; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_language_master (
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
