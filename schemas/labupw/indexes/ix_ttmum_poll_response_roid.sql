-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labupw; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labupw.labupw_poll_response USING btree (response_option_id);


--
