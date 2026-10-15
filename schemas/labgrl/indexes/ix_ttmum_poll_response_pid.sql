-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labgrl; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labgrl.labgrl_poll_response USING btree (poll_id);


--
