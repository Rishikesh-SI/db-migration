-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_poll_response_pid
-- Type: INDEX

-- Name: ix_kxp_poll_response_pid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_poll_response_pid ON labkxp1.labkxp_poll_response USING btree (poll_id);


--
