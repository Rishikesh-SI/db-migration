-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_poll_option_pid
-- Type: INDEX

-- Name: ix_hsl_poll_option_pid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_poll_option_pid ON labhsl.labhsl_poll_option USING btree (poll_id);


--
