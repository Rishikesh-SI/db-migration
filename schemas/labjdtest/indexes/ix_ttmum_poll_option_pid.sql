-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labjdtest; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labjdtest.labjdtest_poll_option USING btree (poll_id);


--
