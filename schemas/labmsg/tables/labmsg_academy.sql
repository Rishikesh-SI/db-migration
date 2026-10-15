-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_academy
-- Type: TABLE

-- Name: labmsg_academy; Type: TABLE; Schema: labmsg; Owner: -
--

CREATE TABLE labmsg.labmsg_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
