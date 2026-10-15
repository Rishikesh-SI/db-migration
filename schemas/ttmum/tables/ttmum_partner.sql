-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_partner
-- Type: TABLE

-- Name: ttmum_partner; Type: TABLE; Schema: ttmum; Owner: -
--

CREATE TABLE ttmum.ttmum_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
