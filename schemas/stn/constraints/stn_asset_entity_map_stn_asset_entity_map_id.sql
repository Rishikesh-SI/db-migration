-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_asset_entity_map stn_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: stn_asset_entity_map stn_asset_entity_map_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_asset_entity_map
    ADD CONSTRAINT stn_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
