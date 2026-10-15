-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_partner
-- Type: TABLE

-- Name: labbg_partner; Type: TABLE; Schema: labbg; Owner: -
--

CREATE TABLE labbg.labbg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
