-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_partner
-- Type: TABLE

-- Name: labtkr_partner; Type: TABLE; Schema: labtkr; Owner: -
--

CREATE TABLE labtkr.labtkr_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
