-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_partner
-- Type: TABLE

-- Name: labuww_partner; Type: TABLE; Schema: labuww; Owner: -
--

CREATE TABLE labuww.labuww_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
