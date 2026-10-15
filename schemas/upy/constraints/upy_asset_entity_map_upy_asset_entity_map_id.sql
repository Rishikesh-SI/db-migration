-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_asset_entity_map upy_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: upy_asset_entity_map upy_asset_entity_map_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_asset_entity_map
    ADD CONSTRAINT upy_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
