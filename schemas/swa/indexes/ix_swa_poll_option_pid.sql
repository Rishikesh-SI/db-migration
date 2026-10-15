-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_poll_option_pid
-- Type: INDEX

-- Name: ix_swa_poll_option_pid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_poll_option_pid ON swa.swa_poll_option USING btree (poll_id);


--
