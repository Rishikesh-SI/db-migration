-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_asset_entity_map labrs_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labrs_asset_entity_map labrs_asset_entity_map_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_asset_entity_map
    ADD CONSTRAINT labrs_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
