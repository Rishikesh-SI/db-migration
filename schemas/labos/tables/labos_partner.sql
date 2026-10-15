-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_partner
-- Type: TABLE

-- Name: labos_partner; Type: TABLE; Schema: labos; Owner: -
--

CREATE TABLE labos.labos_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
