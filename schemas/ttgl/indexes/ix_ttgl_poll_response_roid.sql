-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_poll_response_roid
-- Type: INDEX

-- Name: ix_ttgl_poll_response_roid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_poll_response_roid ON ttgl.ttgl_poll_response USING btree (response_option_id);


--
