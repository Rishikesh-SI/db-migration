-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labdsg; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labdsg.labdsg_poll_option USING btree (poll_id);


--
