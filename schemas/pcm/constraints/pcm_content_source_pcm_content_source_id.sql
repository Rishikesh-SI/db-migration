-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_content_source pcm_content_source_id
-- Type: CONSTRAINT

-- Name: pcm_content_source pcm_content_source_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_content_source
    ADD CONSTRAINT pcm_content_source_id PRIMARY KEY (content_source_id);


--
