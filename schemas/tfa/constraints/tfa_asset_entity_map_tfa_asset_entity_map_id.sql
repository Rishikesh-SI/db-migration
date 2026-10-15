-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_asset_entity_map tfa_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: tfa_asset_entity_map tfa_asset_entity_map_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_asset_entity_map
    ADD CONSTRAINT tfa_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
