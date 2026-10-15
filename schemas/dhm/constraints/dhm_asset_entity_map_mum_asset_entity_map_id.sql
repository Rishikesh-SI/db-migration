-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_asset_entity_map mum_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: dhm_asset_entity_map mum_asset_entity_map_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_asset_entity_map
    ADD CONSTRAINT mum_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
