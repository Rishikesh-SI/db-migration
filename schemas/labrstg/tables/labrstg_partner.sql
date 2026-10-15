-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_partner
-- Type: TABLE

-- Name: labrstg_partner; Type: TABLE; Schema: labrstg; Owner: -
--

CREATE TABLE labrstg.labrstg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
