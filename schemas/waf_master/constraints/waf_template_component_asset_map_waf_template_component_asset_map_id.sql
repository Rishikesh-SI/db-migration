-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_template_component_asset_map waf_template_component_asset_map_id
-- Type: CONSTRAINT

-- Name: waf_template_component_asset_map waf_template_component_asset_map_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_template_component_asset_map
    ADD CONSTRAINT waf_template_component_asset_map_id PRIMARY KEY (template_component_asset_map_id);


--
