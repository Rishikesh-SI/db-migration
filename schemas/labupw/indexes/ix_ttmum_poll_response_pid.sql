-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labupw; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labupw.labupw_poll_response USING btree (poll_id);


--
