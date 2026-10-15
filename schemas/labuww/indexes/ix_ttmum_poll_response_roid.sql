-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labuww.labuww_poll_response USING btree (response_option_id);


--
