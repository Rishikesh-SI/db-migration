-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labbr.labbr_poll_response USING btree (poll_id);


--
