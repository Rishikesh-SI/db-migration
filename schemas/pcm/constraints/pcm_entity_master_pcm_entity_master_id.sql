-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_entity_master pcm_entity_master_id
-- Type: CONSTRAINT

-- Name: pcm_entity_master pcm_entity_master_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_entity_master
    ADD CONSTRAINT pcm_entity_master_id PRIMARY KEY (entity_master_id);


--
