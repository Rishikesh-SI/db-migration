-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_partner
-- Type: TABLE

-- Name: labkkr_partner; Type: TABLE; Schema: labkkr; Owner: -
--

CREATE TABLE labkkr.labkkr_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
