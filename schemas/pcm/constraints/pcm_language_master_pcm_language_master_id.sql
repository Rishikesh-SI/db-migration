-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_language_master pcm_language_master_id
-- Type: CONSTRAINT

-- Name: pcm_language_master pcm_language_master_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_language_master
    ADD CONSTRAINT pcm_language_master_id PRIMARY KEY (language_master_id);


--
