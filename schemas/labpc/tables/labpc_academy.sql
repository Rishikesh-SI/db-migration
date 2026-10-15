-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_academy
-- Type: TABLE

-- Name: labpc_academy; Type: TABLE; Schema: labpc; Owner: -
--

CREATE TABLE labpc.labpc_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
