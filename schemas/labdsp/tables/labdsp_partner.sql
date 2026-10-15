-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_partner
-- Type: TABLE

-- Name: labdsp_partner; Type: TABLE; Schema: labdsp; Owner: -
--

CREATE TABLE labdsp.labdsp_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
