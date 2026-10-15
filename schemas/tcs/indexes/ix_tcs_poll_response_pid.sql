-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_poll_response_pid
-- Type: INDEX

-- Name: ix_tcs_poll_response_pid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_poll_response_pid ON tcs.tcs_poll_response USING btree (poll_id);


--
