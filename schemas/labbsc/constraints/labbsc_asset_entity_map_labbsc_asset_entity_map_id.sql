-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_asset_entity_map labbsc_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labbsc_asset_entity_map labbsc_asset_entity_map_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_asset_entity_map
    ADD CONSTRAINT labbsc_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
