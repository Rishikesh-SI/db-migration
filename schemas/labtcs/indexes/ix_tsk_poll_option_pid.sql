-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_poll_option_pid
-- Type: INDEX

-- Name: ix_tsk_poll_option_pid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_poll_option_pid ON labtcs.labtcs_poll_option USING btree (poll_id);


--
