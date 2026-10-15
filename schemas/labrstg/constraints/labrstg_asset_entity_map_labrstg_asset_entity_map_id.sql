-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_asset_entity_map labrstg_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labrstg_asset_entity_map labrstg_asset_entity_map_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_asset_entity_map
    ADD CONSTRAINT labrstg_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
