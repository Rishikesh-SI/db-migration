-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_component_layout waf_component_layout_id
-- Type: CONSTRAINT

-- Name: waf_component_layout waf_component_layout_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_component_layout
    ADD CONSTRAINT waf_component_layout_id PRIMARY KEY (component_layout_id);


--
