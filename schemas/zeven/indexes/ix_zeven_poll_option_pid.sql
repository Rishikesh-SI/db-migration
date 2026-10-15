-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_poll_option_pid
-- Type: INDEX

-- Name: ix_zeven_poll_option_pid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_poll_option_pid ON zeven.zeven_poll_option USING btree (poll_id);


--
