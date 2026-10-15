-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_poll_option_pid
-- Type: INDEX

-- Name: ix_upy_poll_option_pid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_poll_option_pid ON upy.upy_poll_option USING btree (poll_id);


--
