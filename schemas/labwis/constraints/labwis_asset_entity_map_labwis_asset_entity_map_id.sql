-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_asset_entity_map labwis_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labwis_asset_entity_map labwis_asset_entity_map_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_asset_entity_map
    ADD CONSTRAINT labwis_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
