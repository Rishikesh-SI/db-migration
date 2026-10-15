-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: wp_term_taxonomy
-- Type: TABLE

-- Name: wp_term_taxonomy; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.wp_term_taxonomy (
    term_taxonomy_id bigint DEFAULT nextval('swa.wp_term_taxonomy_term_taxonomy_id_seq'::regclass) NOT NULL,
    term_id bigint NOT NULL,
    taxonomy character varying(32) NOT NULL,
    description text NOT NULL,
    parent bigint NOT NULL,
    count bigint NOT NULL
);


--
