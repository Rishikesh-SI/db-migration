-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_poll_response_pid
-- Type: INDEX

-- Name: ix_mum_poll_response_pid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_poll_response_pid ON tmm.tmm_poll_response USING btree (poll_id);


--
