-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labgt.labgt_poll_response USING btree (poll_id);


--
