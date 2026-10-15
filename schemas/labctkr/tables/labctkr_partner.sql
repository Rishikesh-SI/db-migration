-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: labctkr_partner
-- Type: TABLE

-- Name: labctkr_partner; Type: TABLE; Schema: labctkr; Owner: -
--

CREATE TABLE labctkr.labctkr_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
