-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_runner_feedback labtcs_runner_feedback_id
-- Type: CONSTRAINT

-- Name: labtcs_runner_feedback labtcs_runner_feedback_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_runner_feedback
    ADD CONSTRAINT labtcs_runner_feedback_id PRIMARY KEY (runner_feedback_id);


--
