-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_user_role tsk_user_role_id
-- Type: CONSTRAINT

-- Name: tsk_user_role tsk_user_role_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_user_role
    ADD CONSTRAINT tsk_user_role_id PRIMARY KEY (user_role_id);


--
