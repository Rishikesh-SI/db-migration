-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_partner
-- Type: TABLE

-- Name: labwis_partner; Type: TABLE; Schema: labwis; Owner: -
--

CREATE TABLE labwis.labwis_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
