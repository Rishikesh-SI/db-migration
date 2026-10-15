-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_poll_option_pid
-- Type: INDEX

-- Name: ix_rfg_poll_option_pid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_poll_option_pid ON rfg.rfg_poll_option USING btree (poll_id);


--
