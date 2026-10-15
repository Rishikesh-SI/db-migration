-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: labtmum_partner
-- Type: TABLE

-- Name: labtmum_partner; Type: TABLE; Schema: labtmum; Owner: -
--

CREATE TABLE labtmum.labtmum_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
