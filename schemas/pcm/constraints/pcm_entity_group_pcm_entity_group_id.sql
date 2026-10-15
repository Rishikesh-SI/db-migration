-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_entity_group pcm_entity_group_id
-- Type: CONSTRAINT

-- Name: pcm_entity_group pcm_entity_group_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_entity_group
    ADD CONSTRAINT pcm_entity_group_id PRIMARY KEY (entity_group_id);


--
