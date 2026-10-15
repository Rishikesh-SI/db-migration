-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labadkr.labadkr_poll_response USING btree (response_option_id);


--
