-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_poll_option_pid
-- Type: INDEX

-- Name: ix_isl_poll_option_pid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_poll_option_pid ON isl.isl_poll_option USING btree (poll_id);


--
