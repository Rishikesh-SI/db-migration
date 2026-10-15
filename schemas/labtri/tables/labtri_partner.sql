-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_partner
-- Type: TABLE

-- Name: labtri_partner; Type: TABLE; Schema: labtri; Owner: -
--

CREATE TABLE labtri.labtri_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
