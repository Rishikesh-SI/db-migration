-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_action pcm_action_id
-- Type: CONSTRAINT

-- Name: pcm_action pcm_action_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_action
    ADD CONSTRAINT pcm_action_id PRIMARY KEY (action_id);


--
