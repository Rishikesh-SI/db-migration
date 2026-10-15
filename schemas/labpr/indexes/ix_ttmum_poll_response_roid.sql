-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labpr; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labpr.labpr_poll_response USING btree (response_option_id);


--
