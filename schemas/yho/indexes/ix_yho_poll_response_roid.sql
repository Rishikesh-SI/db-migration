-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_poll_response_roid
-- Type: INDEX

-- Name: ix_yho_poll_response_roid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_poll_response_roid ON yho.yho_poll_response USING btree (response_option_id);


--
