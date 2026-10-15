-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labrg; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labrg.labrg_poll_response USING btree (response_option_id);


--
