-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_poll_option_pid
-- Type: INDEX

-- Name: ix_kxp_poll_option_pid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_poll_option_pid ON kxp.kxp_poll_option USING btree (poll_id);


--
