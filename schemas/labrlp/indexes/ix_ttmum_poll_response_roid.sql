-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labrlp; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labrlp.labrlp_poll_response USING btree (response_option_id);


--
