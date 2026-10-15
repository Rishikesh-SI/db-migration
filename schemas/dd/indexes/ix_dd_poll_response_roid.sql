-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_poll_response_roid
-- Type: INDEX

-- Name: ix_dd_poll_response_roid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_poll_response_roid ON dd.dd_poll_response USING btree (response_option_id);


--
