-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_poll_response_pid
-- Type: INDEX

-- Name: ix_scom_poll_response_pid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_poll_response_pid ON scom.scom_poll_response USING btree (poll_id);


--
