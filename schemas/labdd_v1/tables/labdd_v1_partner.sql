-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_partner
-- Type: TABLE

-- Name: labdd_v1_partner; Type: TABLE; Schema: labdd_v1; Owner: -
--

CREATE TABLE labdd_v1.labdd_v1_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
