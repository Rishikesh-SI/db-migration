-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_academy
-- Type: TABLE

-- Name: labdsg_academy; Type: TABLE; Schema: labdsg; Owner: -
--

CREATE TABLE labdsg.labdsg_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
