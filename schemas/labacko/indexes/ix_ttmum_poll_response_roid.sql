-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: ix_ttmum_poll_response_roid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_roid; Type: INDEX; Schema: labacko; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_roid ON labacko.labacko_poll_response USING btree (response_option_id);


--
