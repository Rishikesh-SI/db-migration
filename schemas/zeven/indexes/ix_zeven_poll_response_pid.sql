-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_poll_response_pid
-- Type: INDEX

-- Name: ix_zeven_poll_response_pid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_poll_response_pid ON zeven.zeven_poll_response USING btree (poll_id);


--
