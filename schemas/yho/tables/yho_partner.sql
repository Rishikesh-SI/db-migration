-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_partner
-- Type: TABLE

-- Name: yho_partner; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
