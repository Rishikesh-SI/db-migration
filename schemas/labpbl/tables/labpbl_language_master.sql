-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_language_master
-- Type: TABLE

-- Name: labpbl_language_master; Type: TABLE; Schema: labpbl; Owner: -
--

CREATE TABLE labpbl.labpbl_language_master (
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
