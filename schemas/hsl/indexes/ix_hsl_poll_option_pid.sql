-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_poll_option_pid
-- Type: INDEX

-- Name: ix_hsl_poll_option_pid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_poll_option_pid ON hsl.hsl_poll_option USING btree (poll_id);


--
