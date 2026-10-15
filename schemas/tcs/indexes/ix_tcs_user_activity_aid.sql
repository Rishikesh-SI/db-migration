-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_user_activity_aid
-- Type: INDEX

-- Name: ix_tcs_user_activity_aid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_user_activity_aid ON tcs.tcs_user_activity USING btree (user_id);


--
