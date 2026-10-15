-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_partner
-- Type: TABLE

-- Name: labfg_partner; Type: TABLE; Schema: labfg; Owner: -
--

CREATE TABLE labfg.labfg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
