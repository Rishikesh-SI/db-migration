-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_container pcm_container_id
-- Type: CONSTRAINT

-- Name: pcm_container pcm_container_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_container
    ADD CONSTRAINT pcm_container_id PRIMARY KEY (container_id);


--
