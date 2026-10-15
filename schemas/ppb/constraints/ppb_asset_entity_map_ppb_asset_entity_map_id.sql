-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_asset_entity_map ppb_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: ppb_asset_entity_map ppb_asset_entity_map_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_asset_entity_map
    ADD CONSTRAINT ppb_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
