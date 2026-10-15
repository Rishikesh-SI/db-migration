-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_asset_entity_map labtri_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labtri_asset_entity_map labtri_asset_entity_map_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_asset_entity_map
    ADD CONSTRAINT labtri_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
