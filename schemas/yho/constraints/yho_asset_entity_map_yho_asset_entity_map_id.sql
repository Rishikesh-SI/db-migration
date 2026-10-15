-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_asset_entity_map yho_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: yho_asset_entity_map yho_asset_entity_map_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_asset_entity_map
    ADD CONSTRAINT yho_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
