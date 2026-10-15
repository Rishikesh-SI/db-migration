-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labecn; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labecn.labecn_poll_response USING btree (response_option_id);


--
