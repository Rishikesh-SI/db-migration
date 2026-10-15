-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_entity_image_map waf_entity_image_map_id
-- Type: CONSTRAINT

-- Name: waf_entity_image_map waf_entity_image_map_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_entity_image_map
    ADD CONSTRAINT waf_entity_image_map_id PRIMARY KEY (entity_image_map_id);


--
