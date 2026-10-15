-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_poll_response_pid
-- Type: INDEX

-- Name: ix_pkl_poll_response_pid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_poll_response_pid ON msl.msl_poll_response USING btree (poll_id);


--
