-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_asset_entity_map tcs_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: tcs_asset_entity_map tcs_asset_entity_map_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_asset_entity_map
    ADD CONSTRAINT tcs_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
