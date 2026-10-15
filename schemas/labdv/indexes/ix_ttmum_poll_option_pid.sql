-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labdv.labdv_poll_option USING btree (poll_id);


--
