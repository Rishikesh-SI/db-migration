-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_poll_response_roid
-- Type: INDEX

-- Name: ix_stn_poll_response_roid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_poll_response_roid ON stn.stn_poll_response USING btree (response_option_id);


--
