-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: labkkr_partner
-- Type: TABLE

-- Name: labkkr_partner; Type: TABLE; Schema: labkkr_beta; Owner: -
--

CREATE TABLE labkkr_beta.labkkr_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
