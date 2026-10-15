-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labstrd; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labstrd.labstrd_poll_option USING btree (poll_id);


--
