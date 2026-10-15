-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_partner
-- Type: TABLE

-- Name: khi_partner; Type: TABLE; Schema: khi; Owner: -
--

CREATE TABLE khi.khi_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
