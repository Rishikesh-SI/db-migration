-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_partner
-- Type: TABLE

-- Name: labkc_partner; Type: TABLE; Schema: labkc; Owner: -
--

CREATE TABLE labkc.labkc_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
