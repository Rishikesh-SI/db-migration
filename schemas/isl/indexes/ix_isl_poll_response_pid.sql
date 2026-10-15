-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_poll_response_pid
-- Type: INDEX

-- Name: ix_isl_poll_response_pid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_poll_response_pid ON isl.isl_poll_response_test USING btree (poll_id);


--
