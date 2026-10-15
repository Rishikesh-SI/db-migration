-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_poll_response_roid
-- Type: INDEX

-- Name: ix_swa_poll_response_roid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_poll_response_roid ON swa.swa_poll_response USING btree (response_option_id);


--
