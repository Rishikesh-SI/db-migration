-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_poll_response_pid
-- Type: INDEX

-- Name: ix_jafc_poll_response_pid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_poll_response_pid ON jafc.jafc_poll_response USING btree (poll_id);


--
