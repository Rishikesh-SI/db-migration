-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_entity_category waf_entity_category_id
-- Type: CONSTRAINT

-- Name: waf_entity_category waf_entity_category_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_entity_category
    ADD CONSTRAINT waf_entity_category_id PRIMARY KEY (entity_category_id);


--
