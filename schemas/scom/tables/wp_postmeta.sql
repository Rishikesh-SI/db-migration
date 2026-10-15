-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: wp_postmeta
-- Type: TABLE

-- Name: wp_postmeta; Type: TABLE; Schema: scom; Owner: -
--

CREATE TABLE scom.wp_postmeta (
    meta_id bigint NOT NULL,
    post_id bigint,
    meta_key character varying(255),
    meta_value text
);


--
