-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_partner
-- Type: TABLE

-- Name: labmao_partner; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
