-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_partner
-- Type: TABLE

-- Name: labsaw_partner; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
