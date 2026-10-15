-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ttgl_partner
-- Type: TABLE

-- Name: ttgl_partner; Type: TABLE; Schema: ttgl; Owner: -
--

CREATE TABLE ttgl.ttgl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
