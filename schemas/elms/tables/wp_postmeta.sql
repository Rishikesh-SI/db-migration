-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: elms
-- Object: wp_postmeta
-- Type: TABLE

-- Name: wp_postmeta; Type: TABLE; Schema: elms; Owner: -
--

CREATE TABLE elms.wp_postmeta (
    meta_id bigint NOT NULL,
    post_id bigint,
    meta_key character varying(255),
    meta_value text
);


--
