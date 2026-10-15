-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_runner_feedback mum_runner_feedback_id
-- Type: CONSTRAINT

-- Name: dhm_runner_feedback mum_runner_feedback_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_runner_feedback
    ADD CONSTRAINT mum_runner_feedback_id PRIMARY KEY (runner_feedback_id);


--
