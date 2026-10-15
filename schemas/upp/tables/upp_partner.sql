-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_partner
-- Type: TABLE

-- Name: upp_partner; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
