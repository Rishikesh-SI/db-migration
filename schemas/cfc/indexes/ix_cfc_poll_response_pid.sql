-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_poll_response_pid
-- Type: INDEX

-- Name: ix_cfc_poll_response_pid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_poll_response_pid ON cfc.cfc_poll_response USING btree (poll_id);


--
