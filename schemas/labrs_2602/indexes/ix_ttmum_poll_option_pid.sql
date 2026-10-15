-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labrs_2602.labrs_poll_option USING btree (poll_id);


--
