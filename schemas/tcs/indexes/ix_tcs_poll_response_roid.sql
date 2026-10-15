-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_poll_response_roid
-- Type: INDEX

-- Name: ix_tcs_poll_response_roid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_poll_response_roid ON tcs.tcs_poll_response USING btree (response_option_id);


--
