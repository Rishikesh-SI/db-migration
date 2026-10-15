-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_asset_entity_map labpcm_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labpcm_asset_entity_map labpcm_asset_entity_map_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_asset_entity_map
    ADD CONSTRAINT labpcm_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
