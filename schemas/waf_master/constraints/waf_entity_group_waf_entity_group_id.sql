-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_entity_group waf_entity_group_id
-- Type: CONSTRAINT

-- Name: waf_entity_group waf_entity_group_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_entity_group
    ADD CONSTRAINT waf_entity_group_id PRIMARY KEY (entity_group_id);


--
