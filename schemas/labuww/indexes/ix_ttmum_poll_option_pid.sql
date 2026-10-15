-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labuww.labuww_poll_option USING btree (poll_id);


--
