-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_user pcm_user_id
-- Type: CONSTRAINT

-- Name: pcm_user pcm_user_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_user
    ADD CONSTRAINT pcm_user_id PRIMARY KEY (user_id);


--
