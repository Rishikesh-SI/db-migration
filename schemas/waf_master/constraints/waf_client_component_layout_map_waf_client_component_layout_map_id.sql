-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_client_component_layout_map waf_client_component_layout_map_id
-- Type: CONSTRAINT

-- Name: waf_client_component_layout_map waf_client_component_layout_map_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_client_component_layout_map
    ADD CONSTRAINT waf_client_component_layout_map_id PRIMARY KEY (client_component_layout_map_id);


--
