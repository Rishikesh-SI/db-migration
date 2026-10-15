-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_poll_response_roid
-- Type: INDEX

-- Name: ix_pbl_poll_response_roid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_poll_response_roid ON pbl.pbl_poll_response USING btree (response_option_id);


--
