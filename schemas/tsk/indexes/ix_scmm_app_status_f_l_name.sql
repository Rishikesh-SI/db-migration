-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_scmm_app_status_f_l_name
-- Type: INDEX

-- Name: ix_scmm_app_status_f_l_name; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_scmm_app_status_f_l_name ON tsk.tsk_app_status USING btree (race, date_of_birth, upper((last_name)::text), upper((first_name)::text));


--
