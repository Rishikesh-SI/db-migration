-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_partner
-- Type: TABLE

-- Name: labkxip_partner; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
