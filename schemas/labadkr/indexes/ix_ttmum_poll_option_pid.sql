-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labadkr.labadkr_poll_option USING btree (poll_id);


--
