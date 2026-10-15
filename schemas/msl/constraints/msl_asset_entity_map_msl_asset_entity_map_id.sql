-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_asset_entity_map msl_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: msl_asset_entity_map msl_asset_entity_map_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_asset_entity_map
    ADD CONSTRAINT msl_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
