-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_partner
-- Type: TABLE

-- Name: labgrl_partner; Type: TABLE; Schema: labgrl; Owner: -
--

CREATE TABLE labgrl.labgrl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
