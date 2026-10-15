-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_asset_entity_map labyho_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labdms_asset_entity_map labyho_asset_entity_map_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_asset_entity_map
    ADD CONSTRAINT labyho_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
