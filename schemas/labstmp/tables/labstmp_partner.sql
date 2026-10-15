-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_partner
-- Type: TABLE

-- Name: labstmp_partner; Type: TABLE; Schema: labstmp; Owner: -
--

CREATE TABLE labstmp.labstmp_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
