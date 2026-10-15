-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_poll_response_roid
-- Type: INDEX

-- Name: ix_abp_poll_response_roid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_poll_response_roid ON abpp.abp_poll_response USING btree (response_option_id);


--
