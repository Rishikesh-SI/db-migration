-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labtmum; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labtmum.labtmum_poll_response USING btree (response_option_id);


--
