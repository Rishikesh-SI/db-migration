-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labecn; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labecn.labecn_poll_option USING btree (poll_id);


--
