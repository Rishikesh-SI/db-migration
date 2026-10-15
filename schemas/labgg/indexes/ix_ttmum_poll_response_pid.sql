-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labgg.labgg_poll_response USING btree (poll_id);


--
