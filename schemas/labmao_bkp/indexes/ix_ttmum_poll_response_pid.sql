-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labmao_bkp; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labmao_bkp.labmao_poll_response USING btree (poll_id);


--
