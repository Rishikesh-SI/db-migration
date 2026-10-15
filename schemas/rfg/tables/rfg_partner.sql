-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_partner
-- Type: TABLE

-- Name: rfg_partner; Type: TABLE; Schema: rfg; Owner: -
--

CREATE TABLE rfg.rfg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
