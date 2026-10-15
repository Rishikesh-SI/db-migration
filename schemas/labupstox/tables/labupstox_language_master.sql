-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_language_master
-- Type: TABLE

-- Name: labupstox_language_master; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_language_master (
    language_master_id numeric NOT NULL,
    language_code character varying(30),
    title character varying(150),
    title_native character varying(150),
    sef character varying(150),
    image character varying(150),
    description character varying(2000),
    published numeric,
    ordering numeric
);


--
