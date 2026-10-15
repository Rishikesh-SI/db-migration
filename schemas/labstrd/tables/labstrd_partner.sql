-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_partner
-- Type: TABLE

-- Name: labstrd_partner; Type: TABLE; Schema: labstrd; Owner: -
--

CREATE TABLE labstrd.labstrd_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
