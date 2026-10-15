-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_topic pcm_topic_id
-- Type: CONSTRAINT

-- Name: pcm_topic pcm_topic_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_topic
    ADD CONSTRAINT pcm_topic_id PRIMARY KEY (topic_id);


--
