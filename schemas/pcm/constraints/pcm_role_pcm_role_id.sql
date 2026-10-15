-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_role pcm_role_id
-- Type: CONSTRAINT

-- Name: pcm_role pcm_role_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_role
    ADD CONSTRAINT pcm_role_id PRIMARY KEY (role_id);


--
