-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_runner_feedback_flname
-- Type: INDEX

-- Name: ix_tsk_runner_feedback_flname; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_runner_feedback_flname ON labtcs.labtcs_runner_feedback USING btree (first_name, last_name);


--
