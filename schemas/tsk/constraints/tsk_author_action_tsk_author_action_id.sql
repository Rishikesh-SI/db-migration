-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_author_action tsk_author_action_id
-- Type: CONSTRAINT

-- Name: tsk_author_action tsk_author_action_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_author_action
    ADD CONSTRAINT tsk_author_action_id PRIMARY KEY (author_action_id);


--
