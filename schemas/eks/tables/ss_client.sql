-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_client
-- Type: TABLE

-- Name: ss_client; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_client (
    client_id integer DEFAULT nextval('eks.ss_client_client_id_seq'::regclass) NOT NULL,
    client_name character varying(100),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
