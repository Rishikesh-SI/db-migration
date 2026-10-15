-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_academy
-- Type: TABLE

-- Name: labpr_academy; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
