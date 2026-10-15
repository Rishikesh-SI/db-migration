-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: wp_term_relationships
-- Type: TABLE

-- Name: wp_term_relationships; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.wp_term_relationships (
    object_id bigint NOT NULL,
    term_taxonomy_id bigint NOT NULL,
    term_order integer NOT NULL
);


--
