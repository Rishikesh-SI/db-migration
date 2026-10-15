-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_runner_performance_history mum_runner_performance_history_id
-- Type: CONSTRAINT

-- Name: dhm_runner_performance_history mum_runner_performance_history_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_runner_performance_history
    ADD CONSTRAINT mum_runner_performance_history_id PRIMARY KEY (runner_performance_history_id);


--
