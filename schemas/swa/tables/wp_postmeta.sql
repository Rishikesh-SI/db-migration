-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: wp_postmeta
-- Type: TABLE

-- Name: wp_postmeta; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.wp_postmeta (
    meta_id bigint DEFAULT nextval('swa.wp_postmeta_meta_id_seq'::regclass) NOT NULL,
    post_id bigint NOT NULL,
    meta_key character varying(255),
    meta_value text
);


--
