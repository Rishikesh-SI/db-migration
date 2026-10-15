-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_poll_option_pid
-- Type: INDEX

-- Name: ix_ppb_poll_option_pid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_poll_option_pid ON ppb.ppb_poll_option USING btree (poll_id);


--
