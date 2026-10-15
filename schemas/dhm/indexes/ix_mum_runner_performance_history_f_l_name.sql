-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_runner_performance_history_f_l_name
-- Type: INDEX

-- Name: ix_mum_runner_performance_history_f_l_name; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_runner_performance_history_f_l_name ON dhm.dhm_runner_performance_history USING btree (date_of_birth, upper((last_name)::text), upper((first_name)::text));


--
