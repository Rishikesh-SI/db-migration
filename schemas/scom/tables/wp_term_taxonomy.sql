-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: wp_term_taxonomy
-- Type: TABLE

-- Name: wp_term_taxonomy; Type: TABLE; Schema: scom; Owner: -
--

CREATE TABLE scom.wp_term_taxonomy (
    term_taxonomy_id bigint NOT NULL,
    term_id bigint,
    taxonomy character varying(32),
    description text,
    parent bigint,
    count bigint
);


--
