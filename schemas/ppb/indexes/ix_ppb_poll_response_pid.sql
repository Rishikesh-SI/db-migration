-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_poll_response_pid
-- Type: INDEX

-- Name: ix_ppb_poll_response_pid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_poll_response_pid ON ppb.ppb_poll_response USING btree (poll_id);


--
