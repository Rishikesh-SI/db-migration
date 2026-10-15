-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_asset_entity_map labdsg_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labdsg_asset_entity_map labdsg_asset_entity_map_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_asset_entity_map
    ADD CONSTRAINT labdsg_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
