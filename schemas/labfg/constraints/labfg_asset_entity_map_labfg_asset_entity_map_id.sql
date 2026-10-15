-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_asset_entity_map labfg_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labfg_asset_entity_map labfg_asset_entity_map_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_asset_entity_map
    ADD CONSTRAINT labfg_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
