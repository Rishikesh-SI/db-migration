-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_asset_entity_map labpc_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labpc_asset_entity_map labpc_asset_entity_map_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_asset_entity_map
    ADD CONSTRAINT labpc_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
