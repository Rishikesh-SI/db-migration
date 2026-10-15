-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_entity_role_map labpcm_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labpcm_entity_role_map labpcm_entity_role_map_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_entity_role_map
    ADD CONSTRAINT labpcm_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
