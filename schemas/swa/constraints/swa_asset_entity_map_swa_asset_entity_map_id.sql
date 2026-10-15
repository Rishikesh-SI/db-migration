-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_asset_entity_map swa_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: swa_asset_entity_map swa_asset_entity_map_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_asset_entity_map
    ADD CONSTRAINT swa_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
