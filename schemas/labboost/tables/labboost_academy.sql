-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_academy
-- Type: TABLE

-- Name: labboost_academy; Type: TABLE; Schema: labboost; Owner: -
--

CREATE TABLE labboost.labboost_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
