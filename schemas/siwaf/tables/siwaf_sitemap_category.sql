-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_sitemap_category
-- Type: TABLE

-- Name: siwaf_sitemap_category; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_sitemap_category (
    category_id numeric,
    category_name character varying(50),
    is_content_asset numeric,
    asset_type_id character varying(10)
);


--
