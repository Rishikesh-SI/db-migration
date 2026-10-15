-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON ttmum.ttmum_poll_option USING btree (poll_id);


--
