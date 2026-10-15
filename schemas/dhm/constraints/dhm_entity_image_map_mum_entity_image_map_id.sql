-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_entity_image_map mum_entity_image_map_id
-- Type: CONSTRAINT

-- Name: dhm_entity_image_map mum_entity_image_map_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_entity_image_map
    ADD CONSTRAINT mum_entity_image_map_id PRIMARY KEY (entity_image_map_id);


--
