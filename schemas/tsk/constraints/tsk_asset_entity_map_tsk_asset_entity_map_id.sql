-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_asset_entity_map tsk_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: tsk_asset_entity_map tsk_asset_entity_map_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_asset_entity_map
    ADD CONSTRAINT tsk_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
