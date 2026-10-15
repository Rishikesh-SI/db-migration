-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_asset_entity_map labtcs_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labtcs_asset_entity_map labtcs_asset_entity_map_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_asset_entity_map
    ADD CONSTRAINT labtcs_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
