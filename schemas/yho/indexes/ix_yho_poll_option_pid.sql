-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_poll_option_pid
-- Type: INDEX

-- Name: ix_yho_poll_option_pid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_poll_option_pid ON yho.yho_poll_option USING btree (poll_id);


--
