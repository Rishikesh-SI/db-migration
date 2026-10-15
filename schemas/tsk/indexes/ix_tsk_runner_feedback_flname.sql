-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_runner_feedback_flname
-- Type: INDEX

-- Name: ix_tsk_runner_feedback_flname; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_runner_feedback_flname ON tsk.tsk_runner_feedback USING btree (first_name, last_name);


--
