-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_partner
-- Type: TABLE

-- Name: labdms_partner; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
