-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_user_activity_aid
-- Type: INDEX

-- Name: ix_user_activity_aid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_user_activity_aid ON khi.khi_user_activity USING btree (user_id);


--
