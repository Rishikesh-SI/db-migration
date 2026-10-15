-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_partner
-- Type: TABLE

-- Name: labpr_partner; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
