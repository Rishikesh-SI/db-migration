-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_asset_entity_map labstmp_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labstmp_asset_entity_map labstmp_asset_entity_map_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_asset_entity_map
    ADD CONSTRAINT labstmp_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
