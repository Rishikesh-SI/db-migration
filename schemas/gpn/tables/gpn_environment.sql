-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_environment
-- Type: TABLE

-- Name: gpn_environment; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_environment (
    environment_id numeric NOT NULL,
    environment_name character varying(256),
    environment_topic_suffix character varying(256)
);


--
