-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_poll_option_pid
-- Type: INDEX

-- Name: ix_upp_poll_option_pid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_poll_option_pid ON upp.upp_poll_option USING btree (poll_id);


--
