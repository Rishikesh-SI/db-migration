-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_poll_response_roid
-- Type: INDEX

-- Name: ix_tsk_poll_response_roid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_poll_response_roid ON labtcs.labtcs_poll_response USING btree (response_option_id);


--
