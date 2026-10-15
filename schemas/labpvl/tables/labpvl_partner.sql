-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_partner
-- Type: TABLE

-- Name: labpvl_partner; Type: TABLE; Schema: labpvl; Owner: -
--

CREATE TABLE labpvl.labpvl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
