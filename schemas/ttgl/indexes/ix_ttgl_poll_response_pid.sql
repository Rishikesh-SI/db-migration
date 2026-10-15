-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_poll_response_pid
-- Type: INDEX

-- Name: ix_ttgl_poll_response_pid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_poll_response_pid ON ttgl.ttgl_poll_response USING btree (poll_id);


--
