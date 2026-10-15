-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_article_asset_map tfa_article_asset_map_id
-- Type: CONSTRAINT

-- Name: tfa_article_asset_map tfa_article_asset_map_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_article_asset_map
    ADD CONSTRAINT tfa_article_asset_map_id PRIMARY KEY (article_asset_map_id);


--
