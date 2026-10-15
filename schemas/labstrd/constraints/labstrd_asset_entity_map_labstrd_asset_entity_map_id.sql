-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_asset_entity_map labstrd_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labstrd_asset_entity_map labstrd_asset_entity_map_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_asset_entity_map
    ADD CONSTRAINT labstrd_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
