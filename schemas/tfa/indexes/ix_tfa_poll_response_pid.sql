-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_poll_response_pid
-- Type: INDEX

-- Name: ix_tfa_poll_response_pid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_poll_response_pid ON tfa.tfa_poll_response USING btree (poll_id);


--
