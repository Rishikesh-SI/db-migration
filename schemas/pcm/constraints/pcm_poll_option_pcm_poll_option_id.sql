-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_poll_option pcm_poll_option_id
-- Type: CONSTRAINT

-- Name: pcm_poll_option pcm_poll_option_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_poll_option
    ADD CONSTRAINT pcm_poll_option_id PRIMARY KEY (poll_option_id);


--
