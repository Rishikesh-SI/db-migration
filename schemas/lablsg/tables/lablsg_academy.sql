-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_academy
-- Type: TABLE

-- Name: lablsg_academy; Type: TABLE; Schema: lablsg; Owner: -
--

CREATE TABLE lablsg.lablsg_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
