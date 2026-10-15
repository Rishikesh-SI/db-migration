-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_poll_response_roid
-- Type: INDEX

-- Name: ix_hsl_poll_response_roid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_poll_response_roid ON hsl.hsl_poll_response USING btree (response_option_id);


--
