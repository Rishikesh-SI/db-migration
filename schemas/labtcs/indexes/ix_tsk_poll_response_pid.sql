-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_poll_response_pid
-- Type: INDEX

-- Name: ix_tsk_poll_response_pid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_poll_response_pid ON labtcs.labtcs_poll_response USING btree (poll_id);


--
