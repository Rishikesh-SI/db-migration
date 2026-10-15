-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labdd_v1.labdd_v1_poll_response USING btree (poll_id);


--
