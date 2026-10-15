-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labwskl; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labwskl.labwskl_poll_response USING btree (response_option_id);


--
