-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_user_activity_aid
-- Type: INDEX

-- Name: ix_upp_user_activity_aid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_user_activity_aid ON utt.utt_user_activity USING btree (user_id);


--
