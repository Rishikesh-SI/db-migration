-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_partner
-- Type: TABLE

-- Name: labgfg_partner; Type: TABLE; Schema: labgfg; Owner: -
--

CREATE TABLE labgfg.labgfg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
