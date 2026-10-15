-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_partner
-- Type: TABLE

-- Name: kxp_partner; Type: TABLE; Schema: kxp; Owner: -
--

CREATE TABLE kxp.kxp_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
