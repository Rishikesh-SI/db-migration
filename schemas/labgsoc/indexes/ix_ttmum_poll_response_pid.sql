-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labgsoc; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labgsoc.labgsoc_poll_response USING btree (poll_id);


--
