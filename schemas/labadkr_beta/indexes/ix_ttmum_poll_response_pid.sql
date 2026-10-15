-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labadkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labadkr_beta.labadkr_poll_response USING btree (poll_id);


--
