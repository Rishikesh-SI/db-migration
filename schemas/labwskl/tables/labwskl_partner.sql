-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_partner
-- Type: TABLE

-- Name: labwskl_partner; Type: TABLE; Schema: labwskl; Owner: -
--

CREATE TABLE labwskl.labwskl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
