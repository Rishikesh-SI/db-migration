-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_client_sitemap_category_map
-- Type: TABLE

-- Name: siwaf_client_sitemap_category_map; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_client_sitemap_category_map (
    client_sitemap_category_map_id numeric,
    client_code character varying,
    sitemap_category_id numeric,
    is_paginated numeric,
    page_limit numeric,
    entity_role_id numeric,
    prefix character varying(100),
    postfix character varying(100),
    is_checked numeric
);


--
