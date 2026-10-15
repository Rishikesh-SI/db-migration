-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_partner
-- Type: TABLE

-- Name: labpkl_partner; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.labpkl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
