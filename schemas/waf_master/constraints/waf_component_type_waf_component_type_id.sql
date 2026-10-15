-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_component_type waf_component_type_id
-- Type: CONSTRAINT

-- Name: waf_component_type waf_component_type_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_component_type
    ADD CONSTRAINT waf_component_type_id PRIMARY KEY (component_type_id);


--
