-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labmi_v1.labmi_v1_poll_option USING btree (poll_id);


--
