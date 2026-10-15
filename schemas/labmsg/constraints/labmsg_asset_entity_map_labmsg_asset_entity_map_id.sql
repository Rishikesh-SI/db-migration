-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_asset_entity_map labmsg_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labmsg_asset_entity_map labmsg_asset_entity_map_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_asset_entity_map
    ADD CONSTRAINT labmsg_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
