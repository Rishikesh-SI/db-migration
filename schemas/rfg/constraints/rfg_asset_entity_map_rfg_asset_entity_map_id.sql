-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_asset_entity_map rfg_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: rfg_asset_entity_map rfg_asset_entity_map_id; Type: CONSTRAINT; Schema: rfg; Owner: -
--

ALTER TABLE ONLY rfg.rfg_asset_entity_map
    ADD CONSTRAINT rfg_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
