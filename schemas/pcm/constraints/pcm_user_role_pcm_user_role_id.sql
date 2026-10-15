-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_user_role pcm_user_role_id
-- Type: CONSTRAINT

-- Name: pcm_user_role pcm_user_role_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_user_role
    ADD CONSTRAINT pcm_user_role_id PRIMARY KEY (user_role_id);


--
