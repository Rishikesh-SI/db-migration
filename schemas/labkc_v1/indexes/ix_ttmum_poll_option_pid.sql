-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labkc_v1.labkc_v1_poll_option USING btree (poll_id);


--
