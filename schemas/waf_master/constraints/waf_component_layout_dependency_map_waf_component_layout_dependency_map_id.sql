-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_component_layout_dependency_map waf_component_layout_dependency_map_id
-- Type: CONSTRAINT

-- Name: waf_component_layout_dependency_map waf_component_layout_dependency_map_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_component_layout_dependency_map
    ADD CONSTRAINT waf_component_layout_dependency_map_id PRIMARY KEY (component_layout_dependency_map_id);


--
