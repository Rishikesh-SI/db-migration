-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_runner_performance_history mum_runner_performance_history_id
-- Type: CONSTRAINT

-- Name: tmm_runner_performance_history mum_runner_performance_history_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_runner_performance_history
    ADD CONSTRAINT mum_runner_performance_history_id PRIMARY KEY (runner_performance_history_id);


--
