-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_poll_response_roid
-- Type: INDEX

-- Name: ix_mum_poll_response_roid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_poll_response_roid ON tmm.tmm_poll_response USING btree (response_option_id);


--
