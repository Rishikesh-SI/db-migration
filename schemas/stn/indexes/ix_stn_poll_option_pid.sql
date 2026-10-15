-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_poll_option_pid
-- Type: INDEX

-- Name: ix_stn_poll_option_pid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_poll_option_pid ON stn.stn_poll_option USING btree (poll_id);


--
