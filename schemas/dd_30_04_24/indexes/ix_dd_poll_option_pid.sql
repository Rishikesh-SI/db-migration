-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_poll_option_pid
-- Type: INDEX

-- Name: ix_dd_poll_option_pid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_poll_option_pid ON dd_30_04_24.dd_poll_option USING btree (poll_id);


--
