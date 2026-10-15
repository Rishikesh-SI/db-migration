-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_asset_entity_map labgg_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labgg_asset_entity_map labgg_asset_entity_map_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_asset_entity_map
    ADD CONSTRAINT labgg_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
