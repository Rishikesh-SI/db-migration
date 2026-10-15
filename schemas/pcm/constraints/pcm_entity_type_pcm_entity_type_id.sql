-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_entity_type pcm_entity_type_id
-- Type: CONSTRAINT

-- Name: pcm_entity_type pcm_entity_type_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_entity_type
    ADD CONSTRAINT pcm_entity_type_id PRIMARY KEY (entity_type_id);


--
