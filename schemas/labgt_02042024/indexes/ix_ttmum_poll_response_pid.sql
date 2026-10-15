-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labgt_02042024.labgt_poll_response USING btree (poll_id);


--
