-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_runner_performance_history mum_runner_performance_history_id
-- Type: CONSTRAINT

-- Name: tmmimg_upd_runner_performance_history mum_runner_performance_history_id; Type: CONSTRAINT; Schema: tmmimg_upd; Owner: -
--

ALTER TABLE ONLY tmmimg_upd.tmmimg_upd_runner_performance_history
    ADD CONSTRAINT mum_runner_performance_history_id PRIMARY KEY (runner_performance_history_id);


--
