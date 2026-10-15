-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labecn_v1_bkp_29012025.labecn_v1_poll_response USING btree (poll_id);


--
