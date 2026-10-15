-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labpr; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labpr.labpr_poll_option USING btree (poll_id);


--
