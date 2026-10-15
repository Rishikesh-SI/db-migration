-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: ix_ttmum_poll_option_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_option_pid; Type: INDEX; Schema: labacko; Owner: -
--

CREATE INDEX ix_ttmum_poll_option_pid ON labacko.labacko_poll_option USING btree (poll_id);


--
