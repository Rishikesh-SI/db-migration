-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_poll_response_pid
-- Type: INDEX

-- Name: ix_stn_poll_response_pid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_poll_response_pid ON stn.stn_poll_response USING btree (poll_id);


--
