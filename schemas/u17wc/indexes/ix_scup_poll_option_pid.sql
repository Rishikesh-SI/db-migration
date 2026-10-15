-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_poll_option_pid
-- Type: INDEX

-- Name: ix_scup_poll_option_pid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_poll_option_pid ON u17wc.u17wc_poll_option USING btree (poll_id);


--
