-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_poll_option_pid
-- Type: INDEX

-- Name: ix_tsk_poll_option_pid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_poll_option_pid ON tsk.tsk_poll_option USING btree (poll_id);


--
