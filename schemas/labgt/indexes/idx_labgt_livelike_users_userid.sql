-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_livelike_users_userid
-- Type: INDEX

-- Name: idx_labgt_livelike_users_userid; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_livelike_users_userid ON labgt.labgt_livelike_users USING btree (userid);


--
