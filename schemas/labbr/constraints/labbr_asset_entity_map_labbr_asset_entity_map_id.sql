-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_asset_entity_map labbr_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labbr_asset_entity_map labbr_asset_entity_map_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_asset_entity_map
    ADD CONSTRAINT labbr_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
