-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_partner
-- Type: TABLE

-- Name: labkxp_partner; Type: TABLE; Schema: labkxp; Owner: -
--

CREATE TABLE labkxp.labkxp_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
