-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_sitemap_matches
-- Type: TABLE

-- Name: siwaf_sitemap_matches; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_sitemap_matches (
    sitemap_match_id numeric NOT NULL,
    client_code character varying(10),
    match_id character varying(100),
    match_end_date timestamp without time zone,
    sitemap_url text,
    created_date timestamp without time zone,
    p_data jsonb
);


--
