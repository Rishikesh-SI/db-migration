-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_entity_language_map pcm_entity_language_map_id
-- Type: CONSTRAINT

-- Name: pcm_entity_language_map pcm_entity_language_map_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_entity_language_map
    ADD CONSTRAINT pcm_entity_language_map_id PRIMARY KEY (entity_language_map_id);


--
