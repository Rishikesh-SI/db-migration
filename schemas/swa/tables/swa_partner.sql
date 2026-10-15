-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_partner
-- Type: TABLE

-- Name: swa_partner; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
