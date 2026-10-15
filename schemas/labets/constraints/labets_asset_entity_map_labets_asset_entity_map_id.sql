-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_asset_entity_map labets_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labets_asset_entity_map labets_asset_entity_map_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_asset_entity_map
    ADD CONSTRAINT labets_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
