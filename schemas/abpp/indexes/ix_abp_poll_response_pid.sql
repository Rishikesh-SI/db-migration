-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_poll_response_pid
-- Type: INDEX

-- Name: ix_abp_poll_response_pid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_poll_response_pid ON abpp.abp_poll_response USING btree (poll_id);


--
