-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_poll_response_roid
-- Type: INDEX

-- Name: ix_ppb_poll_response_roid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_poll_response_roid ON ppb.ppb_poll_response USING btree (response_option_id);


--
