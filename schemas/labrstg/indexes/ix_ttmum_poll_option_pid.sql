-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labrstg.labrstg_poll_option USING btree (poll_id);


--
