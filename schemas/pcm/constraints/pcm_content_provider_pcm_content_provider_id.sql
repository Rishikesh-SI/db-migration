-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_content_provider pcm_content_provider_id
-- Type: CONSTRAINT

-- Name: pcm_content_provider pcm_content_provider_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_content_provider
    ADD CONSTRAINT pcm_content_provider_id PRIMARY KEY (content_provider_id);


--
