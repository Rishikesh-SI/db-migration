-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_poll_response_roid
-- Type: INDEX

-- Name: ix_rfg_poll_response_roid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_poll_response_roid ON rfg.rfg_poll_response USING btree (response_option_id);


--
