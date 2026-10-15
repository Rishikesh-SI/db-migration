-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_user_poll_response_poll_user
-- Type: INDEX

-- Name: idx_user_poll_response_poll_user; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_user_poll_response_poll_user ON labgt.labgt_user_poll_response USING btree (poll_id, user_id);


--
