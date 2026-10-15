-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_partner
-- Type: TABLE

-- Name: labwf_partner; Type: TABLE; Schema: labwf; Owner: -
--

CREATE TABLE labwf.labwf_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
