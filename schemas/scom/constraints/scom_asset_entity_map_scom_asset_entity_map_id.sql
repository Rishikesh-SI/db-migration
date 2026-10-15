-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_asset_entity_map scom_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: scom_asset_entity_map scom_asset_entity_map_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_asset_entity_map
    ADD CONSTRAINT scom_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
