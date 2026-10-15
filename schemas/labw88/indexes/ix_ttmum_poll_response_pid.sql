-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labw88.labw88_poll_response USING btree (poll_id);


--
