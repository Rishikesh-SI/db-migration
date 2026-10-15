-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_asset_entity_map jafc_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: jafc_asset_entity_map jafc_asset_entity_map_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_asset_entity_map
    ADD CONSTRAINT jafc_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
