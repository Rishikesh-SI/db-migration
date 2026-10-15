-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labgt01_v1.labgt01_v1_poll_option USING btree (poll_id);


--
