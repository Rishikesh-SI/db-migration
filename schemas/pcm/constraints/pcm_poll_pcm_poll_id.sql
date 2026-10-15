-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_poll pcm_poll_id
-- Type: CONSTRAINT

-- Name: pcm_poll pcm_poll_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_poll
    ADD CONSTRAINT pcm_poll_id PRIMARY KEY (poll_id);


--
