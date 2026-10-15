-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_user tsk_user_id
-- Type: CONSTRAINT

-- Name: tsk_user tsk_user_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_user
    ADD CONSTRAINT tsk_user_id PRIMARY KEY (user_id);


--
