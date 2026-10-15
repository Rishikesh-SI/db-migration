-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_runners_target mum_runner_target_id
-- Type: CONSTRAINT

-- Name: dhm_runners_target mum_runner_target_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_runners_target
    ADD CONSTRAINT mum_runner_target_id PRIMARY KEY (runner_target_id);


--
