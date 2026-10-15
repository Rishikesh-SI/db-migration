-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiug
-- Object: labkiug_partner
-- Type: TABLE

-- Name: labkiug_partner; Type: TABLE; Schema: labkiug; Owner: -
--

CREATE TABLE labkiug.labkiug_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
