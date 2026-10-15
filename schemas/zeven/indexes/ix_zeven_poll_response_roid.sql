-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_poll_response_roid
-- Type: INDEX

-- Name: ix_zeven_poll_response_roid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_poll_response_roid ON zeven.zeven_poll_response USING btree (response_option_id);


--
