-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: wp_postmeta
-- Type: TABLE

-- Name: wp_postmeta; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.wp_postmeta (
    meta_id bigint NOT NULL,
    post_id bigint,
    meta_key character varying(255),
    meta_value text
);


--
