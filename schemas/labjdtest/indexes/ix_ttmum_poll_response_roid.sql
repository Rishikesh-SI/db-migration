-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labjdtest; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labjdtest.labjdtest_poll_response USING btree (response_option_id);


--
