-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_partner
-- Type: TABLE

-- Name: labgt_partner; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
