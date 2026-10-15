-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_asset_entity_map labmi_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labmi_asset_entity_map labmi_asset_entity_map_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_asset_entity_map
    ADD CONSTRAINT labmi_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
