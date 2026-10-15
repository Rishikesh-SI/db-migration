-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_article_asset_map pcm_article_asset_map_id
-- Type: CONSTRAINT

-- Name: pcm_article_asset_map pcm_article_asset_map_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_article_asset_map
    ADD CONSTRAINT pcm_article_asset_map_id PRIMARY KEY (article_asset_map_id);


--
