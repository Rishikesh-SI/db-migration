-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labctkr; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labctkr.labctkr_poll_response USING btree (response_option_id);


--
