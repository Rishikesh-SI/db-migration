-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_partner
-- Type: TABLE

-- Name: labrs_partner; Type: TABLE; Schema: labrs_2602; Owner: -
--

CREATE TABLE labrs_2602.labrs_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
