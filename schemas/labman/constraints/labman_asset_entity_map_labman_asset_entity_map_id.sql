-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_asset_entity_map labman_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labman_asset_entity_map labman_asset_entity_map_id; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_asset_entity_map
    ADD CONSTRAINT labman_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
