-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_partner
-- Type: TABLE

-- Name: labisp_partner; Type: TABLE; Schema: labisp; Owner: -
--

CREATE TABLE labisp.labisp_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
