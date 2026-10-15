-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: wp_terms
-- Type: TABLE

-- Name: wp_terms; Type: TABLE; Schema: gsf; Owner: -
--

CREATE TABLE gsf.wp_terms (
    term_id bigint NOT NULL,
    name character varying(200),
    slug character varying(200),
    term_group bigint,
    si_entity_role_id numeric
);


--
