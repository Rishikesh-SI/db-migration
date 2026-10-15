-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_partner
-- Type: TABLE

-- Name: tmm_partner; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
