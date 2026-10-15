-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_asset_entity_map pcm_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: pcm_asset_entity_map pcm_asset_entity_map_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_asset_entity_map
    ADD CONSTRAINT pcm_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
