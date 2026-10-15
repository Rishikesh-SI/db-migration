-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_partner
-- Type: TABLE

-- Name: labgsoc_partner; Type: TABLE; Schema: labgsoc; Owner: -
--

CREATE TABLE labgsoc.labgsoc_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
