-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_partner
-- Type: TABLE

-- Name: upy_partner; Type: TABLE; Schema: upy; Owner: -
--

CREATE TABLE upy.upy_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
