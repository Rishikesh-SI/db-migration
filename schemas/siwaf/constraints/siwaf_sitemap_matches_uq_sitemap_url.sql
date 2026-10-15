-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_sitemap_matches uq_sitemap_url
-- Type: CONSTRAINT

-- Name: siwaf_sitemap_matches uq_sitemap_url; Type: CONSTRAINT; Schema: siwaf; Owner: -
--

ALTER TABLE ONLY siwaf.siwaf_sitemap_matches
    ADD CONSTRAINT uq_sitemap_url UNIQUE (sitemap_url);


--
