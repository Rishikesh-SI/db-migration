-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_runner_feedback tsk_runner_feedback_id
-- Type: CONSTRAINT

-- Name: tsk_runner_feedback tsk_runner_feedback_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_runner_feedback
    ADD CONSTRAINT tsk_runner_feedback_id PRIMARY KEY (runner_feedback_id);


--
