-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_environment
-- Type: TABLE

-- Name: gpn_environment; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_environment (
    environment_id numeric NOT NULL,
    environment_name character varying(20),
    environment_topic_suffix character varying(10)
);


--
