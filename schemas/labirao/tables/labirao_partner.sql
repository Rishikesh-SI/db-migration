-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_partner
-- Type: TABLE

-- Name: labirao_partner; Type: TABLE; Schema: labirao; Owner: -
--

CREATE TABLE labirao.labirao_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
