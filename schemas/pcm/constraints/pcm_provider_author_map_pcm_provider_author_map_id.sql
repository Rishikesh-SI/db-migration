-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_provider_author_map pcm_provider_author_map_id
-- Type: CONSTRAINT

-- Name: pcm_provider_author_map pcm_provider_author_map_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_provider_author_map
    ADD CONSTRAINT pcm_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
