-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_asset_entity_map labpr_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labpr_asset_entity_map labpr_asset_entity_map_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_asset_entity_map
    ADD CONSTRAINT labpr_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
