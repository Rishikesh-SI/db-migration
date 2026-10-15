-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labgfg; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labgfg.labgfg_poll_response USING btree (response_option_id);


--
