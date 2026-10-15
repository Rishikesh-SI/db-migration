-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_asset_entity_map pkl_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: pkl_asset_entity_map pkl_asset_entity_map_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_asset_entity_map
    ADD CONSTRAINT pkl_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
