-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_asset_entity_map labsm_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labsm_asset_entity_map labsm_asset_entity_map_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_asset_entity_map
    ADD CONSTRAINT labsm_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
