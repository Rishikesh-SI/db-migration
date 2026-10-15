-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labal_nassr.labal_nassr_poll_option USING btree (poll_id);


--
