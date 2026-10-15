-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: elms
-- Object: elms_partner
-- Type: TABLE

-- Name: elms_partner; Type: TABLE; Schema: elms; Owner: -
--

CREATE TABLE elms.elms_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
