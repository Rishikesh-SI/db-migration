-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labso_bkp.labso_poll_response USING btree (response_option_id);


--
