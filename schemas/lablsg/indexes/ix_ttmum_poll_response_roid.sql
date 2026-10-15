-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: lablsg; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON lablsg.lablsg_poll_response USING btree (response_option_id);


--
