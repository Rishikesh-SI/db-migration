-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_user_activity_aid
-- Type: INDEX

-- Name: ix_user_activity_aid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_user_activity_aid ON tfa.tfa_user_activity USING btree (user_id);


--
