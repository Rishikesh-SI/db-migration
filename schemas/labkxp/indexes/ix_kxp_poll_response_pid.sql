-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_poll_response_pid
-- Type: INDEX

-- Name: ix_kxp_poll_response_pid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_poll_response_pid ON labkxp.labkxp_poll_response USING btree (poll_id);


--
