-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_partner
-- Type: TABLE

-- Name: labhkind_partner; Type: TABLE; Schema: labhkind; Owner: -
--

CREATE TABLE labhkind.labhkind_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
