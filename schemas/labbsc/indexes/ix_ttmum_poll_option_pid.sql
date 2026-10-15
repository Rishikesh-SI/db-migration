-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labbsc; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labbsc.labbsc_poll_option USING btree (poll_id);


--
