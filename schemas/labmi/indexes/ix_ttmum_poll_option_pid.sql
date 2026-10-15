-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labmi.labmi_poll_option USING btree (poll_id);


--
