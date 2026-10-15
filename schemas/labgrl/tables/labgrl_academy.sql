-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_academy
-- Type: TABLE

-- Name: labgrl_academy; Type: TABLE; Schema: labgrl; Owner: -
--

CREATE TABLE labgrl.labgrl_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
