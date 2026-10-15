-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_runners_target mum_runner_target_id
-- Type: CONSTRAINT

-- Name: tmm_runners_target mum_runner_target_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_runners_target
    ADD CONSTRAINT mum_runner_target_id PRIMARY KEY (runner_target_id);


--
