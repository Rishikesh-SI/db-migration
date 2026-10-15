-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labecn_bkp07062024; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labecn_bkp07062024.labecn_poll_response USING btree (response_option_id);


--
