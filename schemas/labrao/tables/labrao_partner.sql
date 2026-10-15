-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_partner
-- Type: TABLE

-- Name: labrao_partner; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
