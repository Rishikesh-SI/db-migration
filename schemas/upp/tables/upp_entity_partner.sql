-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_entity_partner
-- Type: TABLE

-- Name: upp_entity_partner; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric NOT NULL,
    partner_id numeric NOT NULL,
    handle character varying(50),
    profile_url character varying(3000)
);


--
