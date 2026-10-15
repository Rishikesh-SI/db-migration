-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_article_asset_map tsk_article_asset_map_id
-- Type: CONSTRAINT

-- Name: tsk_article_asset_map tsk_article_asset_map_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_article_asset_map
    ADD CONSTRAINT tsk_article_asset_map_id PRIMARY KEY (article_asset_map_id);


--
