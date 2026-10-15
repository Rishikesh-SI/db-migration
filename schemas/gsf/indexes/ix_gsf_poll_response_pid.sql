-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_poll_response_pid
-- Type: INDEX

-- Name: ix_gsf_poll_response_pid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_poll_response_pid ON gsf.gsf_poll_response USING btree (poll_id);


--
