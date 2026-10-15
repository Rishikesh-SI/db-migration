-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_poll_option_pid
-- Type: INDEX

-- Name: ix_khi_poll_option_pid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_poll_option_pid ON khi.khi_poll_option USING btree (poll_id);


--
