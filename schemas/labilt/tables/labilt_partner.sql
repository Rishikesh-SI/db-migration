-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_partner
-- Type: TABLE

-- Name: labilt_partner; Type: TABLE; Schema: labilt; Owner: -
--

CREATE TABLE labilt.labilt_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
