-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_client
-- Type: TABLE

-- Name: gpn_client; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_client (
    client_id numeric NOT NULL,
    client_name character varying(100) NOT NULL,
    client_code character varying(10) NOT NULL,
    client_configuration jsonb
);


--
