-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_partner
-- Type: TABLE

-- Name: gsf_partner; Type: TABLE; Schema: gsf; Owner: -
--

CREATE TABLE gsf.gsf_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
