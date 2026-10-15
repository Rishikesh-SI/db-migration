-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: lablakr; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON lablakr.lablakr_poll_response USING btree (poll_id);


--
