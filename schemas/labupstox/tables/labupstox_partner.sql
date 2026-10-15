-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_partner
-- Type: TABLE

-- Name: labupstox_partner; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
