-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_poll_response_roid
-- Type: INDEX

-- Name: ix_gsf_poll_response_roid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_poll_response_roid ON gsf.gsf_poll_response USING btree (response_option_id);


--
