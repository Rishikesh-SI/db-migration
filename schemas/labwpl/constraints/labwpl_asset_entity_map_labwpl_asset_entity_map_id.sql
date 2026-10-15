-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_asset_entity_map labwpl_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labwpl_asset_entity_map labwpl_asset_entity_map_id; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_asset_entity_map
    ADD CONSTRAINT labwpl_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
