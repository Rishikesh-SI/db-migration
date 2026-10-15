-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_asset_entity_map labgt_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labgt_asset_entity_map labgt_asset_entity_map_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_asset_entity_map
    ADD CONSTRAINT labgt_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
