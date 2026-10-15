-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_partner
-- Type: TABLE

-- Name: labw88_partner; Type: TABLE; Schema: labw88; Owner: -
--

CREATE TABLE labw88.labw88_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
