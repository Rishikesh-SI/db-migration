-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_asset_entity_map gsf_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: gsf_asset_entity_map gsf_asset_entity_map_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_asset_entity_map
    ADD CONSTRAINT gsf_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
