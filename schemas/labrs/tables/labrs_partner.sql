-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_partner
-- Type: TABLE

-- Name: labrs_partner; Type: TABLE; Schema: labrs; Owner: -
--

CREATE TABLE labrs.labrs_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
