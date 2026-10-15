-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_runner_feedback_flname
-- Type: INDEX

-- Name: ix_mum_runner_feedback_flname; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_runner_feedback_flname ON dhm.dhm_runner_feedback USING btree (first_name, last_name);


--
