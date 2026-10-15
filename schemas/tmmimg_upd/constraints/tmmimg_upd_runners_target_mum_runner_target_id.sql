-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_runners_target mum_runner_target_id
-- Type: CONSTRAINT

-- Name: tmmimg_upd_runners_target mum_runner_target_id; Type: CONSTRAINT; Schema: tmmimg_upd; Owner: -
--

ALTER TABLE ONLY tmmimg_upd.tmmimg_upd_runners_target
    ADD CONSTRAINT mum_runner_target_id PRIMARY KEY (runner_target_id);


--
