-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_partner
-- Type: TABLE

-- Name: labpcm_partner; Type: TABLE; Schema: labpcm; Owner: -
--

CREATE TABLE labpcm.labpcm_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
