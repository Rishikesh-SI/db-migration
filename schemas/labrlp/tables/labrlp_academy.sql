-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_academy
-- Type: TABLE

-- Name: labrlp_academy; Type: TABLE; Schema: labrlp; Owner: -
--

CREATE TABLE labrlp.labrlp_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
