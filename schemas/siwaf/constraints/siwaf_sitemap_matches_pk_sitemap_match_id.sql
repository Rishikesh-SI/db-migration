-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_sitemap_matches pk_sitemap_match_id
-- Type: CONSTRAINT

-- Name: siwaf_sitemap_matches pk_sitemap_match_id; Type: CONSTRAINT; Schema: siwaf; Owner: -
--

ALTER TABLE ONLY siwaf.siwaf_sitemap_matches
    ADD CONSTRAINT pk_sitemap_match_id PRIMARY KEY (sitemap_match_id);


--
