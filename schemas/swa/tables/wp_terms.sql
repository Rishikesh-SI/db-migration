-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: wp_terms
-- Type: TABLE

-- Name: wp_terms; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.wp_terms (
    term_id bigint DEFAULT nextval('swa.wp_terms_term_id_seq'::regclass) NOT NULL,
    name character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    term_group bigint NOT NULL,
    si_entity_role_id numeric
);


--
