-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labwf.labwf_poll_response USING btree (response_option_id);


--
