-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_partner
-- Type: TABLE

-- Name: labetpl_partner; Type: TABLE; Schema: labetpl; Owner: -
--

CREATE TABLE labetpl.labetpl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
