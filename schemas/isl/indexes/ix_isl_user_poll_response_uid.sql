-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_user_poll_response_uid
-- Type: INDEX

-- Name: ix_isl_user_poll_response_uid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_user_poll_response_uid ON isl.isl_user_poll_response USING btree (user_id, poll_id);


--
