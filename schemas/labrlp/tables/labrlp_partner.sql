-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_partner
-- Type: TABLE

-- Name: labrlp_partner; Type: TABLE; Schema: labrlp; Owner: -
--

CREATE TABLE labrlp.labrlp_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
