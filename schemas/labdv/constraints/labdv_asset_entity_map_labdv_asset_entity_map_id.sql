-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_asset_entity_map labdv_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labdv_asset_entity_map labdv_asset_entity_map_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_asset_entity_map
    ADD CONSTRAINT labdv_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
