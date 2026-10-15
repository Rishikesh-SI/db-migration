-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_partner
-- Type: TABLE

-- Name: pbl_partner; Type: TABLE; Schema: pbl; Owner: -
--

CREATE TABLE pbl.pbl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
