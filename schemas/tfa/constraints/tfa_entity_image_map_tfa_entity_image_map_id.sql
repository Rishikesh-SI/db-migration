-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_entity_image_map tfa_entity_image_map_id
-- Type: CONSTRAINT

-- Name: tfa_entity_image_map tfa_entity_image_map_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_entity_image_map
    ADD CONSTRAINT tfa_entity_image_map_id PRIMARY KEY (entity_image_map_id);


--
