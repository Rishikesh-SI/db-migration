-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_poll_response_pid
-- Type: INDEX

-- Name: ix_tsk_poll_response_pid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_poll_response_pid ON tsk.tsk_poll_response USING btree (poll_id);


--
