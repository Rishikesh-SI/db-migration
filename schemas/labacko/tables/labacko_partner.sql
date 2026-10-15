-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_partner
-- Type: TABLE

-- Name: labacko_partner; Type: TABLE; Schema: labacko; Owner: -
--

CREATE TABLE labacko.labacko_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
