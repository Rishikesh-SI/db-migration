-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_poll_response_roid
-- Type: INDEX

-- Name: ix_hsl_poll_response_roid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_poll_response_roid ON labhsl.labhsl_poll_response USING btree (response_option_id);


--
