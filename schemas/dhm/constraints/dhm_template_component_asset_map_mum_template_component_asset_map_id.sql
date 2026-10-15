-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_template_component_asset_map mum_template_component_asset_map_id
-- Type: CONSTRAINT

-- Name: dhm_template_component_asset_map mum_template_component_asset_map_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_template_component_asset_map
    ADD CONSTRAINT mum_template_component_asset_map_id PRIMARY KEY (template_component_asset_map_id);


--
