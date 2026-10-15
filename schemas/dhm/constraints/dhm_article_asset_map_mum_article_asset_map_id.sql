-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_article_asset_map mum_article_asset_map_id
-- Type: CONSTRAINT

-- Name: dhm_article_asset_map mum_article_asset_map_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_article_asset_map
    ADD CONSTRAINT mum_article_asset_map_id PRIMARY KEY (article_asset_map_id);


--
