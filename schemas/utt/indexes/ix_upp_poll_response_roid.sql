-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_poll_response_roid
-- Type: INDEX

-- Name: ix_upp_poll_response_roid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_poll_response_roid ON utt.utt_poll_response USING btree (response_option_id);


--
