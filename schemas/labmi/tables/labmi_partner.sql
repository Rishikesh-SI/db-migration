-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_partner
-- Type: TABLE

-- Name: labmi_partner; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
